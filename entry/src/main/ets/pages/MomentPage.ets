import PostTable from "../common/database/tables/PostTable";
import { PostsListComponent } from "../view/PostsListComponent";
import PostModel from "../viewmodel/PostModel";
import { router } from "@kit.ArkUI";

@Entry
@Component
export struct MomentPage {
  // 存放帖子列表数据
  @State posts: Array<PostTable> = [];
  @State isLike: boolean = false;
  @State isRefreshing: boolean = true
  private PostTable = new PostTable(() => {
  });

  onPageShow(): void {
    console.log("日志：MomentPage onPageShow")
  }

  aboutToAppear(): void {
    this.PostTable.getRdbStore(() => {
      this.PostTable.query(0, (result: PostTable[]) => {
        this.posts = result;
        // 打印数据
        console.log("日志：MomentPage查询，" + JSON.stringify(this.posts))
      }, true);
    })
  }

  build() {
    Column() {
      Refresh({ refreshing: $$this.isRefreshing }) {
        //当posts中没有数据时显示暂无数据
        if (this.posts.length === 0) {
          Text("暂无数据")
            .height('100%')
        } else {
          List() {
            ForEach(this.posts, (post: PostModel) => {

              ListItem() {
                PostsListComponent({ post })
              }
              .onClick(() => {
                console.log("日志：点击了帖子，" + JSON.stringify(post))
                router.pushUrl({
                  url: 'view/postComponent',
                  params: post
                })
              })

            })
          }
          .height('100%')

        }
      }
      .onRefreshing(() => {
        setTimeout(() => {
          this.isRefreshing = false;
        }, 2000)
        console.log('日志：已刷新');
        // 刷新数据
        this.PostTable.query(0, (result: PostTable[]) => {
          this.posts = result;
          // 打印数据
          console.log("日志：MomentPage查询,刷新，" + JSON.stringify(this.posts))
        }, true);
      })
    }
    .height('100%')
  }
}