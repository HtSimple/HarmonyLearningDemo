import { month } from './month';
import { getNextNMonth, getNextNDay, getStartDate, getToday ,getMonthWeeks } from './tools';
import { TitleStyle, SubTitleStyle, ItemHeight, callback, ItemSpace } from './const';

@Component
export struct calendar {
  @StorageLink("titleDate") @Watch('titleDateChanged') titleDate: number[] = getToday()
  @State index: number = 1;
  @State data: number[][] = [
    getNextNMonth(this.titleDate, -1),
    this.titleDate,
    getNextNMonth(this.titleDate, 1)
  ]
  @State offsetY: number = 0;
  @State positionY: number = 0;
  @State @Watch('changeView') showMonth: boolean = true;
  @State thisMonthLength: number = (getNextNDay(this.titleDate, 35)[1] == this.titleDate[1]) ? 6 : 5;
  @State weeks: number = getMonthWeeks(this.titleDate);

  private titleDateChanged() {
    callback(new Date(this.titleDate[0], this.titleDate[1] - 1, this.titleDate[2]))
    this.changeView()
    this.weeks = getMonthWeeks(this.titleDate);
  }

  private changeView() {
    this.data[this.index] = this.titleDate;
    this.indexChanged();
    this.refreshIndex();
  }

  private refreshIndex() {
    this.changeIndex(this.index);
  }

  private changeIndex(index: number) {
    if (this.showMonth) {
      this.data[(index + 2) % 3] = getNextNMonth(this.data[index], -1);
      this.data[(index + 1) % 3] = getNextNMonth(this.data[index], 1);
    } else {
      this.data[(index + 2) % 3] = getNextNDay(this.data[index], -7);
      this.data[(index + 1) % 3] = getNextNDay(this.data[index], 7);
    }
  }

  private indexChanged() {
    this.thisMonthLength = (getNextNDay(getStartDate(this.titleDate), 35)[1] == this.titleDate[1]) ? 6 : 5;
  }

  // 四个按钮逻辑
  private prevMonth() {
    this.titleDate = getNextNMonth(this.titleDate, -1);
  }

  private nextMonth() {
    this.titleDate = getNextNMonth(this.titleDate, 1);
  }

  private prevYear() {
    let d = [...this.titleDate];
    d[0] -= 1;
    this.titleDate = d;
  }

  private nextYear() {
    let d = [...this.titleDate];
    d[0] += 1;
    this.titleDate = d;
  }

  build() {
    Column() {
      // 标题栏：左右按钮 + 居中标题
      Row() {
        // 左侧按钮
        Row() {
          Button() {
            Text('<<') // 箭头文本
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .colorBlend(Color.Gray) // 箭头灰色
          }
          .border({
            width: 1,
            color: '#CCCCCC', // 边框颜色
            style: BorderStyle.Dashed,
            radius: 2
          })
          .width(24)
          .height(24)
          .padding(0)
          .backgroundColor('#FFFFFF')
          .onClick(() => this.prevYear())
          .margin({right:6})
          Button() {
            Text('<') // 箭头文本
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .colorBlend(Color.Gray) // 箭头灰色
          }
          .border({
            width: 1,
            color: '#CCCCCC', // 边框颜色
            style: BorderStyle.Dashed,
            radius: 2
          })
          .width(24)
          .height(24)
          .padding(0)
          .backgroundColor('#FFFFFF')
          .onClick(() => this.prevMonth())
          //.margin({right:18})
        }
        .width('auto')
        .margin({right : 12})


        // 中间标题
        Text(`${this.titleDate[0]}年${this.titleDate[1]}月`)
          .fontColor(TitleStyle.FontColor)
          .fontSize(TitleStyle.FontSize)
          .fontWeight(TitleStyle.FontWeight)
          .textAlign(TextAlign.Center)


        // 右侧按钮
        Row() {
          Button() {
            Text('>') // 箭头文本
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .colorBlend(Color.Gray) // 箭头灰色
          }
          .border({
            width: 1,
            color: '#CCCCCC', // 边框颜色
            style: BorderStyle.Dashed,
            radius: 2
          })
          .width(24)
          .height(24)
          .padding(0)
          .backgroundColor('#FFFFFF')
          .onClick(() => this.nextMonth())
          .margin({right:6})
          Button() {
            Text('>>') // 箭头文本
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .colorBlend(Color.Gray) // 箭头灰色
          }
          .border({
            width: 1,
            color: '#CCCCCC', // 边框颜色
            style: BorderStyle.Dashed,
            radius: 2
          })
          .width(24)
          .height(24)
          .padding(0)
          .backgroundColor('#FFFFFF')
          .onClick(() => this.nextYear())
        }
        .width('auto')
        .margin({left : 12})
      }
      .margin({ bottom: 16 })
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .height(44)

      // 星期标题行
      Row() {
        ForEach(["日", "一", "二", "三", "四", "五", "六"], (item: string, index: number) => {
          Column() {
            Text(item)
              .fontColor(SubTitleStyle.FontColor)
              .fontSize(SubTitleStyle.FontSize)
              .fontWeight(SubTitleStyle.FontWeight)
          }
          .layoutWeight(1)
          .height('100%')
        })
      }
      .width('100%')
      .height(SubTitleStyle.Height)
      .margin({bottom : 12})

      // 月份内容
      Column() {
        Swiper() {
          ForEach(this.data, (item: number[], index: number) => {
            month({
              showDate: item,
              offsetY: this.offsetY
            });
          })
        }
        .cachedCount(3)
        .loop(true)
        .index(this.index)
        .indicator(false)
        .width('100%')
        .height(this.weeks * ItemHeight)
        .itemSpace(ItemSpace)
        .onChange((index) => {
          this.index = index;
          this.titleDate = this.data[this.index];
          this.refreshIndex()
        })
      }
      .width('100%')
    }
  }
}
