
/**
 * 获取这个月日历显示的第一天
 * @param date
 * @returns
 */
export function getStartDate(date: number[]): number[] {
  let dateTime = new Date(date[0], date[1] - 1, 1);
  dateTime = new Date(dateTime.setDate(dateTime.getDate() - dateTime.getDay()));
  return [(dateTime.getFullYear()), (dateTime.getMonth() + 1), (dateTime.getDate())]
}

export function getNextNMonth(date: number[], n: number): number[] {
  let dateTime = new Date(date[0], date[1] - 1, date[2]);
  dateTime = new Date(dateTime.setMonth(dateTime.getMonth() + n));
  return [(dateTime.getFullYear()), (dateTime.getMonth() + 1), (dateTime.getDate())]
}

/**
 * 获取下n天
 * @param date
 * @param n
 * @returns
 */
export function getNextNDay(date: number[], n: number): number[] {
  let dateTime = new Date(date[0], date[1] - 1, date[2]);
  dateTime = new Date(dateTime.setDate(dateTime.getDate() + n));
  return [(dateTime.getFullYear()), (dateTime.getMonth() + 1), (dateTime.getDate())]
}

// 获取当前选中日期
export function getToday(): number[] {
  return [new Date().getFullYear(), new Date().getMonth() + 1, new Date().getDate()];
}

/**
 * 将 [年, 月, 日] 数组转换为 "YYYY-MM-DD" 格式字符串
 * @param date - 数字数组，格式 [年, 月, 日]（如 [2025, 11, 1]）
 * @returns 格式化后的日期字符串（如 "2025-11-01"）
 */
export function formatDateToString(date: number[]): string {
  if (date.length !== 3) {
    // 非法格式，返回空字符串或默认值
    return "";
  }
  const year = date[0];
  const month = date[1];
  const day = date[2];

  // 补全月份和日期为两位数（如 1 → "01"，11 → "11"）
  const monthStr = month.toString().padStart(2, "0");
  const dayStr = day.toString().padStart(2, "0");

  // 拼接为 "YYYY-MM-DD"
  return `${year}-${monthStr}-${dayStr}`;
}

/**
 * 计算指定月份需要显示的周数（行数）
 * @param date 月份的日期数组，格式 [年, 月, 日]
 * @returns 周数（5或6）
 */
export function getMonthWeeks(date: number[]): number {
  // 获取当月第一天的日期对象
  const firstDay = new Date(date[0], date[1] - 1, 1);
  // 获取当月最后一天的日期对象
  const lastDay = new Date(date[0], date[1], 0);
  // 计算当月第一天是周几（0=周日，1=周一...6=周六）
  const firstDayWeekday = firstDay.getDay();
  // 计算当月总天数
  const totalDays = lastDay.getDate();
  // 计算需要显示的周数：(第一天的周数 + 总天数 - 1) / 7 向上取整
  const weeks = Math.ceil((firstDayWeekday + totalDays) / 7);
  return weeks;
}

