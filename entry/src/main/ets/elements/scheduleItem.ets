import {calendarItemStyle} from "./const"

@Component
export struct scheduleItem {
  //@Prop icon: ResourceStr;
  @Prop title: string;
  //传入的开始时间
  @Prop startTime:string;
  // 传入的结束时间，建议格式："YYYY-MM-DD HH:MM"
  @Prop endTime: string;

  private startHM = this.extractHMFromFullTime(this.startTime);
  private endHM = this.extractHMFromFullTime(this.endTime);
  private timeDisplay = (this.startHM!="00:00"||this.endHM!="23:59")?`${this.startHM}-${this.endHM}`:"全天";



  private extractHMFromFullTime(timeStr: string): string {
    // 1. 按空格拆分“日期”和“时间”（如 ["2020-02-02", "12:00:00"]）
    const timeParts = timeStr.split(' ');
    if (timeParts.length < 2) return "--:--";

    // 2. 按冒号拆分时间部分，提取“小时:分钟”（如 ["12", "00", "00"] → "12:00"）
    const hmParts = timeParts[1].split(':');
    if (hmParts.length < 2) return "--:--";

    // 3. 补零为两位数（如 "9:5" → "09:05"）
    const hour = hmParts[0].padStart(2, '0');
    const minute = hmParts[1].padStart(2, '0');
    return `${hour}:${minute}`;
  }

  // 对比当前时间与结束时间，返回样式配置
  isExpired(): boolean {
    // 1. 解析结束时间：按“空格”拆分为日期和时间，再按“-”“:”拆分为具体数值
    const endTimeParts = this.endTime.split(/[- :]/); // 拆分后：["2020","02","02","14","00","00"]

    // 2. 格式校验：完整日期时间应拆分为 6 段（年、月、日、时、分、秒）
    if (endTimeParts.length !== 6) return true;

    // 3. 转换为数值并校验合法性
    const year = parseInt(endTimeParts[0]);
    const month = parseInt(endTimeParts[1]) - 1; // JS 月份 0-11，需减1
    const day = parseInt(endTimeParts[2]);
    const hour = parseInt(endTimeParts[3]);
    const minute = parseInt(endTimeParts[4]);
    // 校验数值合法性（避免 2020-13-32 这类非法日期）
    if (isNaN(year) || isNaN(month) || isNaN(day) || isNaN(hour) || isNaN(minute) ||
      month < 0 || month > 11 || day < 1 || day > 31 || hour > 23 || minute > 59) {
      return true;
    }

    // 4. 构造完整结束时间 Date 对象
    const end = new Date(year, month, day, hour, minute);
    const now = new Date(); // 当前本地时间

    // 5. 对比：结束时间 ≤ 当前时间 → 过期
    return end <= now;
  }


  private getTextColor(): ResourceColor {
    if (this.isExpired()) {
      return calendarItemStyle.FontColor.unableColor;
    }
    return calendarItemStyle.FontColor.defaultColor;
  }

  private getBackgroundColor(): ResourceColor {
    if (this.isExpired()) {
      return calendarItemStyle.BackgroundColor.unableColor;
    }
    return calendarItemStyle.BackgroundColor.defaultColor;
  }

  build() {
    Column({ space: 12 }) {
      Row(){
        Text(this.title)
          .fontSize(calendarItemStyle.FontSize)
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .padding({ left: 40 })
          .foregroundColor(this.getTextColor())
      }

      Row(){
        Text(this.timeDisplay)
          .fontSize(calendarItemStyle.FontSize)
          .width('100%')
          .backgroundColor(this.getBackgroundColor())
          .padding({ left: 40 })
          .foregroundColor(this.getTextColor())
      }
    }
    .backgroundColor(this.getBackgroundColor())
    .width(calendarItemStyle.Width)
    .height(calendarItemStyle.Height)
    .borderRadius(8)
    .padding({top:16,bottom:16})
  }
}