import {calendar} from "../elements/calendar"
import {schedule} from "../elements/schedule"

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
          Stack() {
            // 居中标题
            Text('我的日程')
              .fontSize(20)
              .fontWeight(FontWeight.Normal)
              .align(Alignment.Center)

            // 左侧返回按钮
            Button('<')
              .width(44)
              .height(44)
              .fontSize(24)
              .fontColor('#000000')
              .backgroundColor('#FFFFFF')
              .align(Alignment.Start)
              .position({ left: 0 })
              .onClick(() => {
                this.navPathStack.pop()
              })
          }
          .width('100%')
          .height(44)
          .backgroundColor('#FFFFFF')

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