import router from '@ohos.router';
import {PreferencesUtils} from '../Utils/PreferencesUtils'

@Entry
@Component
struct Index {
  private prefUtils: PreferencesUtils = new PreferencesUtils(); // 实例化工具类

  navPathStack: NavPathStack = new NavPathStack();
  @State currentPage: string = 'login';//当前界面
  @State phoneNumber: string = '';
  @State password: string = '';
  @State showPassword: boolean = false;
  @State rememberPassword: boolean = false;
  @State agreeProtocol: boolean = false;
  @State isPhoneError: boolean = false;
  @State isPasswordError :boolean=false;
  @StorageLink('fontSizeOffset') fontSizeOffset: number = 0 ;
  private images: Resource[] = [
    $r('app.media.banner1'),
    $r('app.media.banner2'),
    $r('app.media.banner3')
  ]


  aboutToAppear() {
    // 初始化 Preferences
    this.prefUtils.getFontPreferences(getContext(this));
    // 从存储中加载字体大小
    let storedSize = this.prefUtils.getChangeFontSize();
    AppStorage.setOrCreate('fontSizeOffset', storedSize); // 初始化全局存储
  }

  changeFontSize(offset: number) {
    this.fontSizeOffset += offset;
    this.prefUtils.saveChangeFontSize(this.fontSizeOffset); // 持久化保存
  }

  build() {
    Navigation(this.navPathStack) {
        this.buildLoginPage(); // 显示登录页
    }
    .hideTitleBar(true)
  }

  @Builder
  buildLoginPage() {
    Scroll() {
      Column() {
        // 头部导航栏开始
        Row() {
          Button({ type: ButtonType.Normal, stateEffect: true }) {
            Text('×')
              .fontSize(30)
              .fontColor('#000000')
          }
          .backgroundColor('transparent')
          .borderRadius(0)
          .borderWidth(0)
          .onClick(() => {
            router.back();
          })
          .margin({ left: 10 })

          Blank()

          Text('注册')
            .fontSize(18)
            .fontColor('#007DFF')
            .margin({ right: 15 })
            .onClick(() => {
              console.info('To register page');
            })
        }
        .width('100%')
        .padding({ top: 10 })

        //头部导航栏结束

        // 标题区域
        Text('欢迎登录')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 30, bottom: 10, left: 35 })
          .width('100%')
          .textAlign(TextAlign.Start)

        Text('为了您的账户安全，请进行身份验证')
          .fontSize(14)
          .fontColor('#999999')
          .margin({ bottom: 30, left: 35 })
          .width('100%')
          .textAlign(TextAlign.Start)

        //手机号码输入框开始
        Column() {
          Text("手机号码")
            .fontSize(16)
            .fontColor('#000000')
            .textAlign(TextAlign.Start)
            .width('90%')
            .margin({ left: 20, bottom: 5 })

          // 手机号输入框
          TextInput({ placeholder: '请输入手机号码' })
            .type(InputType.PhoneNumber)
            .placeholderColor(this.isPhoneError ? '#FF0000' : '#CCCCCC')
            .fontSize(16)
            .margin({ left: 20, right: 20, bottom: 1 })
            .width('90%')
            .height(44)
            .border({
              width: 1,
              color: this.isPhoneError ? '#FF0000' : '#CCCCCC',
              radius: 0
            })
            .backgroundColor('#FFFFFF')
            .padding({ left: 12 })
            .onChange((value: string) => {
              this.phoneNumber = value;
              if (this.isPhoneError) {
                this.isPhoneError = false;
              }
            })

          Divider()
            .margin({ left: 20, right: 20 })
            .color('#EEEEEE')
        }

        //手机号码输入框结束

        // 密码输入框开始
        Column() {
          Text("密码")
            .fontSize(16)
            .fontColor('#000000')
            .textAlign(TextAlign.Start)
            .width('90%')
            .margin({ left: 20, top: 20, bottom: 5 })

          TextInput({ placeholder: '请输入密码(6-20位)' })
            .type(InputType.Password)
            .placeholderColor(this.isPasswordError ? '#FF0000' : '#CCCCCC')
            .fontSize(16)
            .margin({ left: 20, right: 20, bottom: 1 })
            .width('90%')
            .height(44)
            .border({ width: 1, color: this.isPasswordError ? '#FF0000' : '#CCCCCC', radius: 0 })
            .backgroundColor('#FFFFFF')
            .padding({ left: 12 })
            .onChange((value: string) => {
              this.password = value;
              if (this.isPasswordError) {
                this.isPasswordError = false;
              }
            })

          Divider()
            .margin({ left: 20, right: 20 })
            .color('#EEEEEE')
        }

        // 记住密码和忘记密码
        Row() {
          Checkbox()
            .select(this.rememberPassword)
            .onChange((value: boolean) => {
              this.rememberPassword = value;
            })
            .margin({ left: 20 })
            .shape(CheckBoxShape.ROUNDED_SQUARE)

          Text('记住密码')
            .fontSize(14)
            .margin({ left: 5 })

          Blank()

          Text('忘记密码?')
            .fontSize(14)
            .fontColor('#007DFF')
            .margin({ right: 20 })
            .onClick(() => {
              console.info('To forget password page');
            })
        }
        .width('100%')
        .margin({ top: 20, bottom: 40 })

        Blank()

        // 登录按钮（关键改动：添加手机号空值校验）
        Button('登录')
          .width('90%')
          .height(50)
          .fontSize(16)
          .backgroundColor('#007DFF')
          .borderRadius(25)
          .margin({ bottom: 20 })
          .onClick(() => {
            // 先校验手机号是否为空
            if (!this.phoneNumber.trim()) { // trim() 排除“只输入空格”的情况
              this.isPhoneError = true; // 为空则标记错误（输入框变红）
              return;
            }
            // 再检验密码是否为空
            if (!this.password.trim()) { // trim() 排除“只输入空格”的情况
              this.isPasswordError = true; // 为空则标记错误（输入框变红）
              return; // 终止后续逻辑，等待用户输入
            }

            // 协议校验逻辑
            if (!this.agreeProtocol) {
              AlertDialog.show({
                title: '提示',
                message: '请阅读并同意《用户使用协议》和《隐私政策》',
                confirm: {
                  value: '确定',
                  action: () => {
                  }
                }
              });
              return;
            }

            // 手机号、密码和协议都校验通过，执行登录逻辑
            console.info(`Phone: ${this.phoneNumber}, Password: ${this.password}`);
            this.currentPage = 'main';
            this.navPathStack.pushPathByName('myCalendarPage',null);
            console.info('transform from loginPage to myCalendarPage');
          })


        Text('一键登录')
          .fontSize(16)
          .fontColor('#007DFF')
          .margin({ bottom: 20 })
          .onClick(() => {
            this.currentPage = 'main';
            this.navPathStack.pushPathByName('myCalendarPage',null);
            console.info('One-click login');
          })

        Swiper() {
          ForEach(this.images, (item: string) => {
            Image(item)
              .objectFit(ImageFit.Cover)
              .width('100%')
              .height(200)
          })
        }
        .width('60%')
        .height(120)
        .loop(true) // 循环播放
        .autoPlay(true) // 自动轮播
        .interval(3000) // 每 3 秒切换
        .margin({ top: 20, bottom: 20 })

        Column({ space: 20 }) {
          Text('当前字体大小偏移: ' + this.fontSizeOffset)
            .fontSize(16 + this.fontSizeOffset)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 20 })
          Row() {
            Button('字体 +')
              .onClick(() => this.changeFontSize(1))
              .width(80).height(40)

            Button('字体 -')
              .onClick(() => this.changeFontSize(-1))
              .width(80).height(40)

          }

        }
        .width('100%')
        .height('auto')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)

        // 协议勾选（无改动）
        Row() {
          Checkbox()
            .select(this.agreeProtocol)
            .onChange((value: boolean) => {
              this.agreeProtocol = value;
            })
            .margin({ left: 20 })
            .shape(CheckBoxShape.ROUNDED_SQUARE)

          Text('已阅读并同意')
            .fontSize(14 + this.fontSizeOffset)
            .margin({ left: 5 })

          Text('《用户使用协议》')
            .fontSize(14 + this.fontSizeOffset)
            .fontColor('#007DFF')
            .onClick(() => {
              console.info('View user agreement');
            })

          Text('和')
            .fontSize(14 + this.fontSizeOffset)
            .margin({ left: 2, right: 2 })

          Text('《隐私政策》')
            .fontSize(14 + this.fontSizeOffset)
            .fontColor('#007DFF')
            .onClick(() => {
              console.info('View privacy policy');
            })
        }
        .width('100%')
        .margin({ top : 20 })
      }
      .width('100%')
      //.height('100%')
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
    .edgeEffect(EdgeEffect.None)
  }
}