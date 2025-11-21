import {TopNavigationBar} from '../elements/TopNavigationBar'

interface RepeatFrequencyParams {
  onSelect: (frequency: string) => void; // 回调函数，用于更新父页面状态
}

@Builder
export function RepeatFrequencyPageBuilder(){
  RepeatFrequencyPage();
}

@Component
export struct RepeatFrequencyPage {
  private navPathStack: NavPathStack = new NavPathStack();
  private onSelect: (frequency: string) => void = () => {};

  // 1. 定义一个数组来存储所有的重复频率选项
  private frequencyOptions: string[] = [
    '不重复',
    '每天',
    '工作日',
    '每周',
    '每两周',
    '每月',
    '每年'
  ];

  build() {
    NavDestination() {
      Column() {
        TopNavigationBar({
          navPathStack:this.navPathStack,
          title:'重复频率'
        })
        // 重复频率选项列表
        List() {
          // 2. 使用 ForEach 循环遍历数组，生成 ListItem
          ForEach(this.frequencyOptions, (item:string) => {
            ListItem() {
              Text(item)
                .fontSize(16)
                .padding({ left: 16, right: 16, top: 12, bottom: 12 })
                // 3. 根据当前项是否是默认选中项来设置背景色
                .backgroundColor(item === '不重复' ? '#E0EDFF' : '#FFFFFF')
                .width('100%')
                .onClick(() => {
                  this.onSelect(item); // 4. 将当前项的值传递给回调函数
                });
            }
          }, (item:string) => item) // 5. 为 ForEach 指定唯一的 key

          // 自定义（含输入框）- 这一项结构特殊，单独列出
          ListItem() {
            Row() {
              Text('自定义').fontSize(16).padding({ left: 16, top: 12, bottom: 12 });
              TextInput({ placeholder: '输入Corn表达式' })
                .width('50%').height(32).fontSize(14).padding({ left: 8 })
                .backgroundColor('#F5F5F5').borderRadius(4).margin({ right: 16 });
            }.width('100%').backgroundColor('#FFFFFF')
            .onClick(() => {
              // 这里可以获取 TextInput 的值并传递出去
              this.onSelect('自定义');
              this.navPathStack.pop();
            });
          }
        }.width('100%').margin({ top: 16 });

        // 结束重复（示例逻辑，可根据需求扩展）
        Row() {
          Text('结束重复').fontSize(14).fontColor('#666666').margin({ left: 16, top: 16, bottom: 16 });
          Text('无限重复').fontSize(14).fontColor('#000000').margin({ right: 16 });
          Image('common/ic_arrow_right.png').width(16).height(16);
        }.width('100%').justifyContent(FlexAlign.SpaceBetween);

        Text('该日程不重复').fontSize(14).fontColor('#999999').margin({ left: 16, top: 8, bottom: 16 });

        // 确定按钮
        Button('确定')
          .width('90%').height(56).fontSize(16).fontWeight(FontWeight.Medium)
          .backgroundColor('#4088FF').borderRadius(24)
          .margin({ top: 24, bottom: 32, left: '5%', right: '5%' })
          .onClick(() => this.navPathStack.pop());
      }
      .width('100%').height('100%').backgroundColor('#FFFFFF');
    }
    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.navPathStack = context.pathStack;
    });
  }
}