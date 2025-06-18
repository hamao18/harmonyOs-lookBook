// xxx.ets
@Preview
@Entry
@Component
struct RefreshExample {
  @State isRefreshing: boolean = true;
  @State arr: String[] = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];


  build() {
    Column() {
      Refresh({ refreshing: $$this.isRefreshing }) {
        List() {
          ForEach(this.arr, (item: string) => {
            ListItem() {
              Text('' + item)
                .width('70%')
                .height(80)
                .fontSize(16)
                .margin(10)
                .textAlign(TextAlign.Center)
                .borderRadius(10)
                .backgroundColor(0xFFFFFF)
            }
          }, (item: string) => item)
        }
        // .onScrollIndex((first: number) => {
        //   console.info(first.toString());
        // })
        .width('100%')
        .height('100%')
        .alignListItem(ListItemAlign.Center)
        .scrollBar(BarState.Off)
      }
      // .onStateChange((refreshStatus: RefreshStatus) => {
      //   // console.info('Refresh onStatueChange state is ' + refreshStatus);
      //   console.log('刷新');
      // })
      // .onOffsetChange((value: number) => {
      //   console.info('Refresh onOffsetChange offset:' + value);
      // })
      .onRefreshing(() => {
        setTimeout(() => {
          this.isRefreshing = false;
        }, 2000)
        console.log('已刷新');
      })
      .backgroundColor(0x89CFF0)
      .refreshOffset(64)
      .pullToRefresh(true)
    }
  }
}