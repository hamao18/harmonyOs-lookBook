import AccountData from "../viewmodel/AccountData";
import { JSON } from "@kit.ArkTS";
import CommonConstants from "../common/constants/CommonConstants";
import PostModel from "../viewmodel/PostModel";
import PostTable from "../common/database/tables/PostTable";

@CustomDialog
export struct PostingDialog{
  controller?: CustomDialogController;

  private PostTable = new PostTable(() => {});
  @Prop item: AccountData;

  post: PostModel = {
    id: 0,
    userName: CommonConstants.DEFAULT_USERNAME,
    userPicture: CommonConstants.DEFAULT_AVATOR,
    postTitle: '',
    postBody: '',
    commentNum: 0,
    likeNum: 0,
    isLiked: 'false',
    commentStr: ''
  }

  @State title: string = "";
  @State content: string = "";

  aboutToAppear() {
    //初始化
    if(this.item.accountType === 1){
      // 收入
      this.title = "今日分享--收入"
      this.content = `在线分享...在${this.item.typeText}中收入${this.item.amount}元，快来分享你的吧！！！`
    }else{
      // 支出
      this.title = "今日分享--支出"
      this.content = `在线分享...在${this.item.typeText}中支出${this.item.amount}元，快来分享你的吧！！！`
    }
  }

  build() {
    Column() {
      Row(){
        Text('动态')
          .margin({ left: 50,right: 40 })
          .textAlign(TextAlign.End)
          .layoutWeight(3)
        Text('发布')
          .margin({left:10,right:20})
          .textAlign(TextAlign.End)
          .layoutWeight(2)
          .onClick(()=>{
            console.log("日志："+JSON.stringify(this.title+this.content))
            // 数据库存储
            this.post.postTitle = this.title
            this.post.postBody = this.content
            this.PostTable.getRdbStore(()=>{
              this.PostTable.insertData(this.post,()=>{
                console.log("日志：插入成功,"+JSON.stringify(this.post))
              })
            })
            this.controller?.close();
            //弹窗提示，发布成功
            this.getUIContext().showAlertDialog({
              title: "",
              message: "发布成功",
            })
          })
      }
      .margin({top:20,bottom:20})
      .width("100%")

      //标题
      TextInput({
        text: this.title,
      })
        .backgroundColor(Color.White)
        .onChange((value)=>{
          this.title = value
        })

      Text()
        .width("100%")
        .border({
          width: 1,
          color: Color.Gray,
        })
      // 内容
      TextArea({
        text: this.content,
      })
        .backgroundColor(Color.White)
        .onChange((value)=>{
          this.content = value
        })


    }
    .width(CommonConstants.FULL_WIDTH)
    .height(CommonConstants.DIALOG_HEIGHT_2)
    .borderRadius({ topLeft: $r('app.float.font_size_L'), topRight: $r('app.float.font_size_L') })
    .backgroundColor(Color.White)
    .align(Alignment.BottomEnd)
  }
}