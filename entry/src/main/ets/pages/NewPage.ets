@Builder
export function NewPageBuilder() {
  NewPage()
}

@Component
export struct NewPage {
  build() {
    NavDestination() {
      Column() {
        // 顶部导航栏
        Row() {
          Text('主界面')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .height(50)
        .backgroundColor('#F0F0F0')
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center);

        // 主内容区
        Column() {
          Text('欢迎来到新的界面！没有问题！！！')
            .fontSize(18)
            .fontColor('#333333')
            .margin({ top: 20 });


        }
        .width('100%')
        .justifyContent(FlexAlign.Start)
        .alignItems(HorizontalAlign.Center);
      }
      .width('100%')
      .backgroundColor('#FFFFFF');

    }
    .hideTitleBar(true)
  }
}