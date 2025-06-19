import AccountTable from '../common/database/tables/AccountTable';
import AccountData from '../viewmodel/AccountData';
import CommonConstants from '../common/constants/CommonConstants';
import { DialogComponent } from '../view/DialogComponent';
import { ImageList } from '../viewmodel/AccountList';
import Logger from '../common/utils/Logger';
import { PostingDialog } from '../view/PostingDialog';

@Entry
@Component
export struct MainPage {
  @State accounts: Array<AccountData> = [];
  @State searchText: string = '';
  @State isEdit: boolean = false;
  @State isInsert: boolean = false;
  @State newAccount: AccountData = {
    id: 0,
    accountType: 0,
    typeText: '',
    amount: 0
  };
  @State index: number = -1;
  //post弹窗使用
  @State item: AccountData = {
    id: 0,
    accountType: 0,
    typeText: '',
    amount: 0
  };
  private AccountTable = new AccountTable(() => {
  });
  private deleteList: Array<AccountData> = [];
  searchController: SearchController = new SearchController();
  dialogController: CustomDialogController = new CustomDialogController({
    builder: DialogComponent({
      isInsert: $isInsert,
      newAccount: $newAccount,
      confirm: (isInsert: boolean, newAccount: AccountData) => this.accept(isInsert, newAccount)
    }),
    customStyle: true,
    alignment: DialogAlignment.Bottom
  });
  /**
   * post弹窗
   * @param item
   */
  postDialog: CustomDialogController = new CustomDialogController({
    builder: PostingDialog({
      item: this.item,
    }),
    customStyle: true,
    alignment: DialogAlignment.Bottom
  });

  //list右滑分享
  @Builder
  itemEnd(item: AccountData) {
    // 构建尾端滑出组件
    Image($r('app.media.share'))
      .width(30)
      .height(30)
        .margin({
          left: 20,
          right: 20,
          bottom: 10,
          top: 10
        })
      .onClick(() => {
        //日志打印item里的内容
        console.log("日志：" + JSON.stringify(item))
        this.item = item;
        this.postDialog.open()
      })
  }

  //判断插入还是修改
  accept(isInsert: boolean, newAccount: AccountData): void {
    if (isInsert) {
      this.AccountTable.insertData(newAccount, (id: number) => {
        newAccount.id = id;
        this.accounts.push(newAccount);
      });
    } else {
      this.AccountTable.updateData(newAccount, () => {
      });
      let list = this.accounts;
      this.accounts = [];
      list[this.index] = newAccount;
      this.accounts = list;
      this.index = -1;
    }
  }

  //数据初始化，数据库查询
  aboutToAppear() {
    this.AccountTable.getRdbStore(() => {
      this.AccountTable.query(0, (result: AccountData[]) => {
        this.accounts = result;
      }, true);
    });
  }

  //选中列表项
  selectListItem(item: AccountData) {
    this.isInsert = false;
    this.index = this.accounts.indexOf(item);
    this.newAccount = {
      id: item.id,
      accountType: item.accountType,
      typeText: item.typeText,
      amount: item.amount
    };
  }

  //删除列表项
  deleteListItem() {
    for (let i = 0; i < this.deleteList.length; i++) {
      let index = this.accounts.indexOf(this.deleteList[i]);
      this.accounts.splice(index, 1);
      this.AccountTable.deleteData(this.deleteList[i], () => {
      });
    }
    this.deleteList = [];
    this.isEdit = false;
  }

  build() {
    Stack() {
      Column() {
        //logo, 应用名
        Row() {
          //logo
          Image($r('app.media.chicken'))
            .width(50)
            .height(50)
            .borderRadius(25)
            .margin({left:10})

          Text($r('app.string.MainAbility_label'))
            .height($r('app.float.component_size_SP'))
            .fontSize($r('app.float.font_size_L'))
            // .margin({ left: $r('app.float.font_size_L') })

          Image($rawfile('ic_public_edit.svg'))
            .width($r('app.float.component_size_S'))
            .aspectRatio(CommonConstants.FULL_SIZE)
            .margin({ right: $r('app.float.font_size_L') })
            .onClick(() => {
              this.isEdit = true;
            })
        }
        .width(CommonConstants.FULL_WIDTH)
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ top: $r('app.float.edge_size_M'), bottom: $r('app.float.edge_size_MM') })

        //搜索框
        Row() {
          Search({
            value: this.searchText,
            placeholder: CommonConstants.SEARCH_TEXT,
            controller: this.searchController
          })
            .width(CommonConstants.FULL_WIDTH)
            .borderRadius($r('app.float.radius_size_M'))
            .borderWidth($r('app.float.border_size_S'))
            .borderColor($r('app.color.border_color'))
            .placeholderFont({ size: $r('app.float.font_size_M') })
            .textFont({ size: $r('app.float.font_size_M') })
            .backgroundColor('#A0E9E5')
            .onChange((searchValue: string) => {
              this.searchText = searchValue;
            })
            .onSubmit((searchValue: string) => {
              if (searchValue === '') {
                this.AccountTable.query(0, (result: AccountData[]) => {
                  this.accounts = result;
                }, true);
              } else {
                this.AccountTable.query(Number(searchValue), (result: AccountData[]) => {
                  this.accounts = result;
                }, false);
              }
            })
        }
        .width(CommonConstants.FULL_WIDTH)
        .padding({ left: $r('app.float.edge_size_M'), right: $r('app.float.edge_size_M') })
        .margin({ top: $r('app.float.edge_size_S'), bottom: $r('app.float.edge_size_S') })

        //账本数据渲染
        Row() {
          List({ space: CommonConstants.FULL_SIZE }) {
            ForEach(this.accounts, (item: AccountData, index: number) => {
              ListItem() {
                Row() {
                  Image(ImageList[item.typeText])
                    .width($r('app.float.component_size_M'))
                    .aspectRatio(CommonConstants.FULL_SIZE)
                    .margin({ right: $r('app.float.edge_size_MP') })

                  Text(item.typeText)
                    .height($r('app.float.component_size_SM'))
                    .fontSize($r('app.float.font_size_M'))

                  Blank()
                    .layoutWeight(1)

                  if (!this.isEdit) {
                    // 非编辑模式：显示金额信息
                    Text(item.accountType === 0 ? '-' + item.amount.toString() : '+' + item.amount.toString())
                      .fontSize($r('app.float.font_size_M'))  // 设置字体大小
                      .fontColor(item.accountType === 0 ? $r('app.color.pay_color') : $r('app.color.main_color'))  // 根据账目类型设置颜色（支出为红色，收入为绿色）
                      .align(Alignment.End)
                      .flexGrow(CommonConstants.FULL_SIZE)  // 占据剩余空间

                  } else {
                    // 编辑模式：显示复选框用于多选删除
                    Row() {
                      Toggle({ type: ToggleType.Checkbox })  // 创建一个复选框组件
                        .onChange((isOn) => {
                          if (isOn) {
                            this.deleteList.push(item);  // 如果选中，将当前项加入删除列表
                          } else {
                            let index = this.deleteList.indexOf(item);
                            this.deleteList.splice(index, 1);  // 如果取消选中，从删除列表中移除
                          }
                        })
                    }
                    .align(Alignment.End)  // 右对齐
                    .flexGrow(CommonConstants.FULL_SIZE)  // 占据剩余空间
                    .justifyContent(FlexAlign.End)  // 内容右对齐
                  }

                }
                .width(CommonConstants.FULL_WIDTH)
                .padding({ left: $r('app.float.edge_size_M'), right: $r('app.float.edge_size_M') })
              }
              .width(CommonConstants.FULL_WIDTH)
              .height($r('app.float.component_size_LM'))
              .onClick(() => {
                this.selectListItem(item);
                this.dialogController.open();
              })
              // 滑动分享
              .swipeAction({
                end: {
                  builder: () => {
                    // this.item = item;
                    this.itemEnd(item)
                  }
                }
              })

            })
          }
          .width(CommonConstants.FULL_WIDTH)
          .borderRadius($r('app.float.radius_size_L'))
          .backgroundColor('#77DAD2')
        }
        .width(CommonConstants.FULL_WIDTH)
        .padding({ left: $r('app.float.edge_size_M'), right: $r('app.float.edge_size_M') })
        .margin({ top: $r('app.float.edge_size_SM') })

      }
      .width(CommonConstants.FULL_WIDTH)
      .height(CommonConstants.FULL_HEIGHT)

      //添加按钮
      if (!this.isEdit) {
        Button() {
          Image($rawfile('add.png'))
        }
        .width($r('app.float.component_size_MP'))
        .height($r('app.float.component_size_MP'))
        .position({ x: CommonConstants.EDIT_POSITION_X, y: CommonConstants.EDIT_POSITION_Y })
        .onClick(() => {
          this.isInsert = true;
          this.newAccount = {
            id: 0,
            accountType: 0,
            typeText: '',
            amount: 0
          };
          this.dialogController.open();
        })
      }

      //删除
      if (this.isEdit) {
        Button() {
          Image($rawfile('delete.svg'))
            .backgroundColor('#5DCEBE')
        }
        .width($r('app.float.component_size_MP'))
        .height($r('app.float.component_size_MP'))
        .backgroundColor($r('app.color.background_color'))
        .markAnchor({ x: $r('app.float.mark_anchor'), y: CommonConstants.MINIMUM_SIZE })
        .position({ x: CommonConstants.DELETE_POSITION_X, y: CommonConstants.DELETE_POSITION_Y })
        .onClick(() => {
          this.deleteListItem();
        })
      }
    }
    .width(CommonConstants.FULL_WIDTH)
    .height(CommonConstants.FULL_HEIGHT)
    .backgroundColor('#5DCEBE')

  }
}