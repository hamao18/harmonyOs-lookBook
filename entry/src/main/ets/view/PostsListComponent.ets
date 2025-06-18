import PostTable from "../common/database/tables/PostTable";
import PostModel from "../viewmodel/PostModel";

interface LocalPostModel{
  id: number,
  userName: string,
  userPicture:string,
  postTitle:string,
  postBody:string,
  commentNum: number,
  likeNum: number,
  isLiked: string,
  commentStr: string
}


@Entry
@Component
export struct PostsListComponent {
  //存放帖子列表数据
  @Prop post: PostModel;
  @State isLike: boolean = false;
  @State likeNum: number = 0;

  private PostTable = new PostTable(() => {});

  onPageShow(): void {
    console.log("日志：onPageShow")
  }
  aboutToAppear(): void {
    this.likeNum = this.post.likeNum;
    this.isLike = this.post.isLiked == 'true';
  }

  build() {
    Column() {
      //头像，用户名
      Row() {
        Image($r(this.post.userPicture))
          .width(28)
          .borderRadius(20)
          .margin(10)

        Text(this.post.userName)
          .height(20)
          .fontColor('#999b9f')
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)

      //标题
      Text(this.post.postTitle)
        .fontSize(20)
        .fontWeight(600)
        .width('100%')
        .margin({
          left: 20,
          right: 3,
          bottom: 5,
          top: 5
        })

      //文章内容，少显
      Text(this.post.postBody)
        .width('100%')
        .fontSize(14)
        .margin({
          left: 22,
          right: 3,
          bottom: 5,
          top: 5
        })
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .maxLines(2)

      //留言和点赞
      Row({ space: 8 }) {
        Image($r('app.media.message'))
          .width(20)
          .height(20)
          .fillColor('#c7cdd0')
        Text(this.post.commentNum.toString())
        Image($r('app.media.like'))
          .width(22)
          .height(22)
          .fillColor(this.isLike == true ? Color.Pink : '#c7cdd0')
          .onClick(() => {
            if (this.post.isLiked == 'true') {
              this.post.likeNum--;
            } else {
              this.post.likeNum++;
            }
            this.post.isLiked = this.post.isLiked == 'true' ? 'false' : 'true';
            this.isLike = !this.isLike;
            this.likeNum = this.post.likeNum;
            //更新数据
            this.PostTable.getRdbStore(() => {
              this.PostTable.updateData(this.post, () => {
                console.log("日志：更新成功," + JSON.stringify(this.post))
              })
            })
          })
        Text(this.likeNum.toString())
      }
      .width('100%')
      .justifyContent(FlexAlign.End)

      //线
      Divider()
        .strokeWidth(3)
        .color('#e0e0e0')
        .width('100%')
    }
    .width('100%')
  }
}