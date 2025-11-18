import {calendar} from "../elements/calendar"
import {schedule} from "../elements/schedule"
import {TopNavigationBar} from "../elements/TopNavigationBar"

@Builder
export function MainPageBuilder() {
  MainPage()
}

@Preview
@Component
export struct MainPage {
  navPathStack: NavPathStack = new NavPathStack()

  build() {
    NavDestination() {
      Stack() {
        Column() {
          TopNavigationBar({
            navPathStack : this.navPathStack,
            title : '我的日程'
          })

          calendar()

          schedule()
            .margin({ top: 10 })
            .layoutWeight(1)
        }
        .width('100%')
        .padding({bottom:10})

        Button('+')
          .width(56)
          .height(56)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
          .backgroundColor('#007DFF')
          .borderRadius(28)
          .shadow({ radius: 10, color: '#00000020', offsetX: 2, offsetY: 4 })
          .position({ bottom: 16, right: 16 })
          .onClick(() => {
            this.navPathStack.pushPathByName(`addNewCalendarPage`,null)
            console.info('Add button clicked');
          })

      }
      .height('100%')
      .alignContent(Alignment.Top)
    }
    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.navPathStack = context.pathStack;
    })
  }
}