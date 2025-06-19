import { MainPage } from './MainPage'
import { MomentPage } from './MomentPage'
import { SettingPage } from './SettingPage'

@Entry
@Component
struct Index {

  build() {
    Column() {
      Tabs({barPosition: BarPosition.End}){
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

        //设置
        TabContent() {
          SettingPage()
        }
        .tabBar('设置')
      }
      .scrollable(false)
    }
    .height('100%')
    .width('100%')

  }
}