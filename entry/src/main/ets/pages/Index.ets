import { MainPage } from './MainPage'
import { MomentPage } from './MomentPage'

@Entry
@Component
struct Index {

  build() {
    Column() {
      Tabs(){
        //首页
        TabContent() {
          MainPage()
        }
        .tabBar('首页')
        //动态
        TabContent() {
          MomentPage()
        }
        .tabBar('动态')
      }
    }
    .height('100%')
    .width('100%')
  }
}