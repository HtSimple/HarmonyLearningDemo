import promptAction from '@ohos.promptAction';

@Builder
export function AddNewCalendarPageBuilder() {
  AddNewCalendarPage()
}

@Component
export struct AddNewCalendarPage {
  // 状态管理
  @State title: string = '';
  @State hasAttachment: boolean = false;

  navPathStack: NavPathStack = new NavPathStack()

  build() {
    NavDestination() {
      Column() {
        // 顶部导航行
        Stack() {
          // 居中标题
          Text('新建日程')
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

        Column({space : 8}) {
          //标题输入部分
          Column() {
            Row() {
              Flex()
                .width(4)
                .height(20)
                .backgroundColor('#4088FF')
                .margin({ left: 24,right : 8 })
              Text('日程标题')
                .fontColor('#000000')
                .fontSize(16)
              Text('*')
                .fontColor('#FF0000')
                .fontSize(16)
            }
            .width('100%')
            .margin({ bottom: 12 })

            // 输入框
            TextInput({ placeholder: '请输入日程标题' })
              .width('90%')
              .height(44)
              .fontSize(14)
              .padding({ left: 16 })
              .backgroundColor('#FFFFFF')
              .borderColor('#CCCCCC')
              .borderWidth(1)
              .borderRadius(4)
              .margin({bottom:16})
          }
          .backgroundColor('#FFFFFF')
          .padding({top : 16})


          //时间选择部分
          Column({ space: 0 }) {
            // 标题栏
            Row() {
              Flex()
                .width(4)
                .height(20)
                .backgroundColor('#4088FF')
                .margin({ left: 24,right:8 })
              Text('时间')
                .fontSize(16)
                .fontColor('#000000')
              Text('*')
                .fontSize(16)
                .fontColor('#FF0000')
            }
            .width('100%')
            .margin({ top: 16, bottom: 12 })

            // 时间选择区
            Row({ space: 20 }) {
              Column({ space: 4 }) {
                Text('6月13日 周五')
                  .fontSize(14)
                  .fontColor('#666666')
                Text('10:00')
                  .fontSize(14)
                  .fontColor('#000000')
              }
              .width('40%')
              .align(Alignment.Center)

              Text('〉')
                .fontSize(16)
                .fontColor('#999999')
                .margin({ top: 12 })

              Column({ space: 4 }) {
                Text('6月13日 周五')
                  .fontSize(14)
                  .fontColor('#666666')
                Text('11:00')
                  .fontSize(14)
                  .fontColor('#000000')
              }
              .width('40%')
              .align(Alignment.Center)
            }
            .width('100%')
            .margin({ bottom: 16 })

            // 重复频次
            Row() {
              Text('重复频次')
                .fontSize(14)
                .fontColor('#666666')
                .margin({ left: 36 })
              Text('不重复')
                .fontSize(14)
                .fontColor('#000000')
              Image('common/ic_arrow_right.png')
                .width(16)
                .height(16)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ right: 36, bottom: 24 })
          }
          .width('100%')
          .padding(20)
          .backgroundColor('#FFFFFF')
        }


        // 保存按钮
        Button('保存')
          .width('100%')
          .height(56)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .backgroundColor('#4088FF')
          .borderRadius(24)
          .margin({ top: 24, bottom: 32 })
          .onClick(() => {
            if (!this.title) {
              promptAction.showToast({ message: '请输入日程标题' });
              return;
            }
            promptAction.showToast({ message: '日程保存成功' });
            this.navPathStack.pop();
          })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F7F8F9')
    }
    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.navPathStack = context.pathStack;
      console.info("current page config info is " + JSON.stringify(context.getConfigInRouteMap()));
    })
  }
}