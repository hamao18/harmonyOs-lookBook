import CommonConstants from '../common/constants/CommonConstants';
import PostTable from '../common/database/tables/PostTable';
import PostModel from '../viewmodel/PostModel';

@Entry
@Component
struct PostComponent {
  @State isLiked: boolean = false;
  @State commentStr: string = '';
  @State comments: string[] = [];
  //关注状态
  @State focusMeg: string = '+ 关注'
  isFocus: boolean = false;
  //评论变量
  @State comment: string = ''
  //索引
  index: number = 0;
  //帖子
  @State post: PostModel = {
    id: 0,
    userName: CommonConstants.DEFAULT_USERNAME,
    userPicture: CommonConstants.DEFAULT_AVATOR,
    postTitle: '',
    postBody: '',
    commentNum: 0,
    likeNum: 0,
    isLiked: 'false',
    commentStr: ''
  };
  private PostTable = new PostTable(() => {
  });

  onPageShow() {
    const router = this.getUIContext().getRouter();
    if (!router) {
      console.error("路由不存在");
      return;
    }
    console.log("路由存在")
    const params = router.getParams()
    this.post = params as PostModel;
    //comments赋值
    console.log("日志：PostComponent,post:", JSON.stringify(this.post))
    this.commentStr = this.post.commentStr || '';
    if(this.commentStr.length == 0){
      this.comments = [];
    }else{
      this.commentStr.split('!').forEach((item: string) => {
        this.comments.push(item)
      })
    }
    console.log("日志：PostComponent,comments:", JSON.stringify(this.comments))
    console.log("日志：PostComponent,commentStr:", JSON.stringify(this.commentStr))
    this.isLiked = this.post.isLiked == 'true';
    // this.PostTable.getRdbStore(() => {
    // })
  }

  build() {
    Column() {
      //顶栏
      Row() {
        Image($r('app.media.line_chevron_left'))
          .width(30)
          .margin({ right: 60, left: 10 })
          .onClick(() => {
            this.getUIContext().getRouter().back();
          })

        Text('正文')
          .fontSize(16)
          .margin({ right: 60, left: 10 })

        Text('评论')
          .margin({ right: 60 })
          .fontSize(16)

        Image($r('app.media.share'))
          .margin({ left: 20 })
          .width(26)
      }
      .width('100%')
      .height(60)

      //帖子内容
      Scroll() {
        Column() {
          // 背景图展示
          Swiper() {
            Image($r('app.media.default_postImage_2'))
              .width('100%')
              .height(220)
              .borderRadius(10)

          }
          .width('100%')
          .height(250)
          .loop(false)

          //贴主栏
          Row() {
            Image($r(this.post.userPicture))
              .width(50)
              .height(50)
              .borderRadius(20)
              .margin({ left: 10 })
              .backgroundColor(Color.Blue)

            Text(this.post.userName)
              .fontSize(16)
              .margin({ right: 80 })
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .maxLines(1)
              .width(150)

            Text(this.focusMeg)
              .border({
                width: 1,
                radius: 10
              })
              .width(60)
              .textAlign(TextAlign.Center)
              .padding(5)
              .fontSize(14)
              .fontColor(this.isFocus === false ? '#a0a4a6' : '#ffa9abae')
              .backgroundColor(this.isFocus === false ? '#383c40' : '#f3f3f3')
              .onClick(() => {
                this.isFocus = !this.isFocus
                if (this.isFocus) {
                  this.focusMeg = '已关注'
                } else {
                  this.focusMeg = '+ 关注'
                }
              })
          }
          .width('100%')
          .margin({ top: 10 })

          //帖子标题+正文
          Column() {
            //标题
            Text(this.post.postTitle)
              .fontSize(18)
              .fontColor('#000000')
              .margin({ left: 30, top: 10 })
              .fontWeight('bold')
              .textAlign(TextAlign.Start)
              .width('100%')

            //正文
            Text(this.post.postBody)
              .fontSize(16)
              .fontColor('#000000')
              .margin({ left: 30, top: 10 })
              .textAlign(TextAlign.Start)
              .width('100%')
          }
          .margin({ bottom: 20 })
          .width('100%')

          //分隔线
          Text()
            .width('100%')
            .height(3)
            .backgroundColor('#e5e5e5')

          // 评论区
          Column() {
            Text('评论')
              .fontSize(16)
              .fontColor('#000000')
              .margin({ left: 30, top: 10 })
              .textAlign(TextAlign.Start)
              .width('100%')
            //分割线
            Text()
              .width('100%')
              .height(2)
              .backgroundColor('#e5e5e5')
              .margin({ top: 10, bottom: 10 })

            if (this.comments.length == 0) {
              Text('暂无评论')
                .fontSize(16)
                .fontColor('#000000')
                .textAlign(TextAlign.Start)
                .margin({ left: 30, top: 10 })
                .width('100%')
            } else {
              List() {
                ForEach(this.comments, (item: string) => {
                  ListItem() {
                    if(item != ""){
                      Column() {
                        Row() {
                          //头像
                          Image($r(CommonConstants.DEFAULT_AVATOR))
                            .width(50)
                            .height(50)
                            .borderRadius(20)
                            .margin({ left: 10 })
                          //用户名
                          Text(CommonConstants.DEFAULT_USERNAME)
                            .fontSize(16)
                            .margin({ left: 10 })
                        }
                        .width('100%')

                        //评论
                        Text(item)
                          .fontSize(16)
                          .fontColor('#000000')
                          .margin({ left: 30, top: 10 })
                          .textAlign(TextAlign.Start)
                          .width('100%')

                        //分割线
                        Text()
                          .width('100%')
                          .height(2)
                          .backgroundColor('#e5e5e5')
                          .margin({ bottom: 10 })
                      }
                    }
                  }
                })
              }
              .width('100%')
            }
          }
          .width('100%')

        }
        .width('100%')
        .margin({ bottom: 20 })
      }
      .height('85%')

      //发表评论
      Row() {
        TextInput({
          text: this.comment,
          placeholder: '参与讨论'
        })
          .width('70%')
          .backgroundColor(Color.Gray)
          .margin({ left: 10, right: 5 })
          .borderRadius(10)
          .fontSize(18)
          .onChange((value: string) => {
            this.comment = value
          })
          .onSubmit((enterKey: EnterKeyType, event: SubmitEvent) => {
            this.comment = event.text
            if (this.comment.length > 0) {
              this.post.commentStr = this.post.commentStr + this.comment + '!';
              this.post.commentNum++;
              this.commentStr = this.post.commentStr;
              this.comments.push(this.comment)
              //更新操作
              this.PostTable.updateData(this.post, () => {
                console.log("日志：更新成功," + JSON.stringify(this.post))
              })
              this.comment = ''
            }
          })

        Image($r('app.media.send'))
          .width(32)
          .height(32)
          .margin(2)
          .fillColor('#808080')
          .onClick(() => {
            if (this.comment.length > 0) {
              this.post.commentStr = this.post.commentStr + this.comment + '!';
              this.post.commentNum++;
              this.commentStr = this.post.commentStr;
              this.comments.push(this.comment)
              //更新操作
              console.log("日志：更新成功," + JSON.stringify(this.post))
              this.PostTable.updateData(this.post, () => {
              })
              this.comment = ''
            }
          })

        Image($r('app.media.like'))
          .width(32)
          .height(32)
          .margin({ left: 8 })// .fillColor('#808080')
          .fillColor(this.isLiked == true ? Color.Pink : '#c7cdd0')
          .onClick(() => {
            if (this.post.isLiked == 'true') {
              this.post.likeNum--;
            } else {
              this.post.likeNum++;
            }
            this.post.isLiked = this.post.isLiked == 'true' ? 'false' : 'true';
            this.isLiked = !this.isLiked;
            //更新数据
            this.PostTable.updateData(this.post, () => {
              console.log("日志：更新成功," + JSON.stringify(this.post))
            })
          })
      }
      .width('100%')
      .height(60)

    }
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}
