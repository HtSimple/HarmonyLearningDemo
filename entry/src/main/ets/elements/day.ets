import { getToday } from './tools'
import { DateStyle, BackgroundColor, ItemHeight } from './const'

@Component
export struct day {
  @State showDate: number[] = []
  private monthDate: number[] = []
  @StorageLink("titleDate") titleDate: number[] = getToday()

  private isSelected(): boolean {
    return JSON.stringify(this.showDate) === JSON.stringify(this.titleDate);
  }

  private isToday(): boolean {
    return JSON.stringify(this.showDate) === JSON.stringify(getToday());
  }

  private getTextColor(): ResourceColor {
    if (this.isToday()) {
      return this.isSelected() ? BackgroundColor : DateStyle.FontColor.accentColor;
    }
    if (this.isSelected()) {
      return DateStyle.FontColor.accentColor;
    }
    if (this.showDate[1] === this.monthDate[1]) {
      return DateStyle.FontColor.defaultColor;
    }
    return DateStyle.FontColor.unableColor;
  }

  private changeDate() {
    this.titleDate = this.showDate;
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      // 背景框层（蓝色边框正方形）
      if (this.isSelected()) {
        // 绘制选中框
        Row()
          .width('80%')
          .height('80%')
          .backgroundColor(this.isToday() ? DateStyle.BackgroundColor : BackgroundColor)
          .border({
            width: DateStyle.BorderWidth,
            color: DateStyle.BackgroundColor
          })
          .borderRadius(4)
      }

      // 日期文字层
      Text(this.showDate[2].toString())
        .fontSize(DateStyle.FontSize)
        .fontWeight(DateStyle.FontWeight)
        .fontColor(this.getTextColor())
    }
    .width('100%')
    .height('100%')
    .aspectRatio(1)
    .onClick(() => this.changeDate())
    .animation({ duration: 150 })
  }
}
