@Component
export struct TopNavigationBar {
  /**
   * 页面导航
   */
  navPathStack: NavPathStack = new NavPathStack()

  /**
   * 导航栏标题
   */
  title?: string = '';

  /**
   * 是否显示返回按钮
   * @default true
   */
  showBackButton?: boolean = true;

  /**
   * 点击返回按钮的回调
   */
  onBack?: () => void;

  /**
   * 导航栏背景颜色
   * @default '#FFFFFF'
   */
  barbackgroundColor?: string = '#FFFFFF';

  /**
   * 标题颜色
   * @default '#000000'
   */
  titleColor?: string = '#000000';

  /**
   * 返回按钮颜色
   * @default '#000000'
   */
  backButtonColor?: string = '#000000';

  build() {
    Stack() {
      // 标题层
      Text(this.title)
        .fontSize(20)
        .fontWeight(FontWeight.Normal)
        .fontColor(this.titleColor)
        .align(Alignment.Center);

      // 返回按钮层
      if (this.showBackButton) {
        Button() {
          Text('<')
            .fontSize(24)
            .fontColor(this.backButtonColor)
        }
        .width(44)
        .height(44)
        .backgroundColor('transparent')
        .align(Alignment.Center)
        .position({ left: 0 })
        .onClick(() => {
          if (this.onBack) {
            this.onBack();
          } else {
            this.navPathStack.pop();
          }
        });
      }
    }
    .width('100%')
    .height(44)
    .backgroundColor(this.barbackgroundColor)
  }
}