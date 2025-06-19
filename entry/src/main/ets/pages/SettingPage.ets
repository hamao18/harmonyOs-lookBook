import PostTable from "../common/database/tables/PostTable";

@Entry
@Component
export struct SettingPage {
  private PostTable = new PostTable(() => {
  });

  build() {
    Column() {
      Button("清理动态信息")
        .fontSize(20)
        .width(120)
        .height(40)
        .onClick(() => {
          console.log("日志：清理动态信息")
          this.PostTable.deleteAll(() => {
            console.log("日志：清理动态信息成功")
          })
          this.getUIContext().showAlertDialog({
            title: "",
            message: "删除成功",
          })
        })
        .width('100%')
        .height('100%')
    }
  }
}

