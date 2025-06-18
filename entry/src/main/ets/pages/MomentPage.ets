import PostTable from "../common/database/tables/PostTable";
import { PostsListComponent } from "../view/PostsListComponent";
import PostModel from "../viewmodel/PostModel";

@Entry
@Component
export struct MomentPage {
  // 存放帖子列表数据
  @State posts: Array<PostTable> = [];
  @State isLike: boolean = false;
  private PostTable = new PostTable(() => {});

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
      List(){
        ForEach(this.posts, (post: PostModel) => {
          ListItem(){
            PostsListComponent({ post })
          }
        })
      }
    }
    .height('100%')
  }
}