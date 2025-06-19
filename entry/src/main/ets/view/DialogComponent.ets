import { promptAction } from '@kit.ArkUI';
import AccountData from '../viewmodel/AccountData';
import AccountItem from '../viewmodel/AccountItem';
import CommonConstants from '../common/constants/CommonConstants';
import { PayList, EarnList } from '../viewmodel/AccountList';

@CustomDialog
export struct DialogComponent {
  controller?: CustomDialogController;
  @Link isInsert: boolean;
  @Link newAccount: AccountData;
  confirm?: (isInsert: boolean, newAccount: AccountData) => void;
  private scroller: Scroller = new Scroller();
  private inputAmount = '';
  @State payList: Array<AccountItem> = PayList;
  @State earnList: Array<AccountItem> = EarnList;
  @State bgColor: string = '';
  @State curIndex: number = 0;
  @State curType: string = '';

  //
  /**
   * 构建 Tab 标签栏的自定义组件
   * 根据当前选中的索引值显示不同的文本（支出/收入），并设置样式
   * @param index - 当前 Tab 的索引值，0 表示支出，1 表示收入
   */
  @Builder
  TabBuilder(index: number) {
    Column() {
      // 显示 Tab 文本，根据 index 判断是支出还是收入
      Text(index === 0 ? $r('app.string.pay_text') : $r('app.string.income_text'))
        .fontSize($r('app.float.font_size_M'))
        .fontColor(
          this.curIndex === index
            ? $r('app.color.main_color') // 当前选中项使用主色
            : Color.Gray // 非选中项使用灰色
        )
    }
    .width($r('app.float.component_size_MP'))
    .padding({
      top: $r('app.float.edge_size_LM'),
      bottom: $r('app.float.edge_size_S')
    }) // 设置顶部和底部内边距
    .margin({ bottom: $r('app.float.edge_size_S') }) // 设置底部外边距
    .border({
      width: {
        bottom: this.curIndex === index
          ? $r('app.float.border_size_M') // 选中项显示底部边框
          : '' // 非选中项不显示底部边框
      },
      color: this.curIndex === index
        ? $r('app.color.main_color') // 选中项边框颜色为主色
        : Color.White // 非选中项边框颜色为白色
    })
  }

  //显示数据，父组件传递数据
  aboutToAppear() {
    this.inputAmount = this.newAccount.amount.toString();
    this.curIndex = this.newAccount.accountType;
    this.curType = this.newAccount.typeText;
  }

  //选择账单类型
  selectAccount(item: AccountItem) {
    this.newAccount.accountType = item.accountType;
    this.newAccount.typeText = item.typeText;
    this.curType = item.typeText;
  }

  build() {
    Column() {
      Image($rawfile('half.png'))
        .width($r('app.float.component_size_L'))
        .height($r('app.float.component_size_S'))
        .onClick(() => {
          this.controller?.close();
        })

      Tabs({ barPosition: BarPosition.Start, index: this.curIndex }) {
        // 支出
        TabContent() {
          Scroll(this.scroller) {
            Row() {
              ForEach(this.payList, (item: AccountItem) => {
                Column() {
                  Image(this.curType === item.typeText ? item.iconSelected : item.icon)
                    .width($r('app.float.image_size'))
                    .aspectRatio(CommonConstants.FULL_SIZE)

                  Text(item.typeText)
                    .fontSize($r('app.float.font_size_S'))
                    .fontColor(this.curType === item.typeText ? Color.White : $r('app.color.main_color'))
                    .margin({ top: $r('app.float.edge_size_S') })
                }
                .width($r('app.float.component_size_LP'))
                .aspectRatio(CommonConstants.FULL_SIZE)
                .padding({ top: $r('app.float.edge_size_M') })
                .margin({ top: $r('app.float.edge_size_MP'), left: $r('app.float.edge_size_M') })
                .align(Alignment.TopStart)
                .backgroundColor(this.curType === item.typeText ? $r('app.color.main_color') : $r('app.color.background_color'))
                .borderRadius($r('app.float.radius_size_S'))
                .onClick(() => {
                  this.selectAccount(item);
                })
              })
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
        }
        .tabBar(this.TabBuilder(0))
        .margin({ bottom: $r('app.float.edge_size_LP') })

        //收入
        TabContent() {
          Scroll(this.scroller) {
            Row() {
              ForEach(this.earnList, (item: AccountItem) => {
                Column() {
                  Image(this.curType === item.typeText ? item.iconSelected : item.icon)
                    .width($r('app.float.image_size'))
                    .aspectRatio(CommonConstants.FULL_SIZE)

                  Text(item.typeText)
                    .fontSize($r('app.float.font_size_S'))
                    .fontColor(this.curType === item.typeText ? Color.White : $r('app.color.main_color'))
                    .margin({ top: $r('app.float.edge_size_S') })
                }
                .width($r('app.float.component_size_LP'))
                .aspectRatio(CommonConstants.FULL_SIZE)
                .padding({ top: $r('app.float.edge_size_M') })
                .margin({ top: $r('app.float.edge_size_MP'), left: $r('app.float.edge_size_M') })
                .align(Alignment.TopStart)
                .backgroundColor(this.curType === item.typeText ? $r('app.color.main_color') : $r('app.color.background_color'))
                .borderRadius($r('app.float.radius_size_S'))
                .onClick(() => {
                  this.selectAccount(item);
                })
              })
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
        }
        .tabBar(this.TabBuilder(1))
        .margin({ bottom: $r('app.float.edge_size_LP') })
      }
      .width(CommonConstants.FULL_WIDTH)
      .height(CommonConstants.TABS_HEIGHT)
      .vertical(false)
      .barMode(BarMode.Fixed)
      .onChange((index) => {
        this.curIndex = index;
      })

      Column() {
        Text($r('app.string.count_text'))
          .width(CommonConstants.FULL_WIDTH)
          .fontSize($r('app.float.font_size_MP'))
          .fontColor(Color.Black)

        Column() {
          TextInput({
            placeholder: $r('app.string.input_text'),
            text: this.newAccount.amount === 0 ? this.inputAmount : this.newAccount.amount.toString()
          })
            .padding({
              left: CommonConstants.MINIMUM_SIZE,
              top: CommonConstants.MINIMUM_SIZE,
              bottom: CommonConstants.MINIMUM_SIZE
            })
            .borderRadius(CommonConstants.MINIMUM_SIZE)
            .backgroundColor(Color.White)
            .type(InputType.Number)
            .onChange((value: string) => {
              this.inputAmount = value;
            })
        }
        .height($r('app.float.component_size_MP'))
        .padding({ top: $r('app.float.edge_size_MPM'), bottom: $r('app.float.edge_size_MM') })
        .borderWidth({ bottom: CommonConstants.FULL_SIZE })
        .borderColor($r('app.color.border_color'))
      }
      .width(CommonConstants.FULL_WIDTH)
      .padding({ left: $r('app.float.edge_size_M'), right: $r('app.float.edge_size_M') })

      Column() {
        Button() {
          Text($r('app.string.confirm_text'))
            .fontSize($r('app.float.font_size_M'))
            .fontColor(Color.White)
        }
        .width(CommonConstants.FULL_WIDTH)
        .height($r('app.float.component_size_M'))
        .onClick(() => {
          if (this.newAccount.typeText === '' || this.curIndex !== this.newAccount.accountType) {
            promptAction.showToast({ message: CommonConstants.TOAST_TEXT_1, bottom: CommonConstants.PROMPT_BOTTOM });
          } else {
            let regex: RegExp = new RegExp('[1-9][0-9]*');
            let matchValue: Array<string> | null = this.inputAmount.match(regex);
            if (matchValue !== null && matchValue[0] === this.inputAmount) {
              this.newAccount.amount = Number(this.inputAmount);
              this.confirm && this.confirm(this.isInsert, this.newAccount);
              this.controller?.close();
            } else {
              promptAction.showToast({ message: CommonConstants.TOAST_TEXT_2, bottom: CommonConstants.PROMPT_BOTTOM });
            }
          }
        })
      }
      .layoutWeight(CommonConstants.FULL_SIZE)
      .padding({
        bottom: $r('app.float.font_size_L'),
        left: $r('app.float.font_size_L'),
        right: $r('app.float.font_size_L')
      })
      .justifyContent(FlexAlign.End)
    }
    .width(CommonConstants.FULL_WIDTH)
    .height(CommonConstants.DIALOG_HEIGHT)
    .borderRadius({ topLeft: $r('app.float.font_size_L'), topRight: $r('app.float.font_size_L') })
    .backgroundColor(Color.White)
    .align(Alignment.BottomEnd)
  }
}