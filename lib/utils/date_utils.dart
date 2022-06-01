class DateUtils {
  static String getCurrentTime() {
    DateTime date = DateTime.now();
    return "${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}";
  }

  static String getCurrentYMD() {
    DateTime date = DateTime.now();
    return "${date.year}-${date.month < 10 ? "0${date.month}" : date.month}-${date.day < 10 ? "0${date.day}" : date.day}";
  }

  static String getTime(String formattedString) {
    DateTime date = DateTime.parse(formattedString);
    return "${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}";
  }

  static String formatDuration(int seconds) {
    Duration duration = Duration(seconds: seconds);
    int minute = duration.inMinutes;
    int second = duration.inSeconds;
    return "${minute < 10 ? '0$minute' : minute}:${second < 10 ? '0$second' : second}";
  }

  static String formatCountdownTime(int seconds) {
    if (seconds <= 0) return "";

    var d = Duration(seconds: seconds);
    List<String> parts = d.toString().split(':');
    return "0${parts[0]}:${parts[1]}:${parts[2].substring(0, 2)}";
  }

  static DateTime formatDateStr(String formattedString) {
    return DateTime.parse(formattedString);
  }

  static String formatMillisecondsSinceEpoch(int m) {
    if (m == null) return "";
    DateTime date = DateTime.fromMillisecondsSinceEpoch(m);
    return "${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}";
  }

  static String formatMicrosecondsSinceEpoch(int m) {
    if (m == null) return "";
    DateTime date = DateTime.fromMicrosecondsSinceEpoch(m);
    return "${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}";
  }

  static String getDayByMillisecondsSinceEpoch(int m) {
    if (m == null) return "";
    DateTime date = DateTime.fromMillisecondsSinceEpoch(m);
    return "${date.year}-${date.month < 10 ? "0${date.month}" : date.month}-${date.day < 10 ? "0${date.day}" : date.day}";
  }

  static String tranImTimeByStr(String time) {
    if (time == null || time.length == 0) return "";
    var createTime = DateTime.parse(time).millisecondsSinceEpoch / 1000;
    return tranImTime(createTime);
  }

  static String tranImTime(double createTime) {
    String duration;
    int minute = 60;
    int hour = minute * 60;
    int day = hour * 24;
    int week = day * 7;
    int month = day * 30;

    var nowTime = DateTime.now().millisecondsSinceEpoch / 1000; //到秒
    var leftTime = nowTime - createTime;

    if (leftTime / month > 6) {
      duration = getDayByMillisecondsSinceEpoch(createTime.toInt());
    } else if (leftTime / month >= 1) {
      duration = (leftTime / month).floor().toString() + ' months ago';
    } else if (leftTime / week >= 1) {
      duration = (leftTime / week).floor().toString() + ' weeks ago';
    } else if (leftTime / day >= 1) {
      duration = (leftTime / day).floor().toString() + ' days ago';
    } else if (leftTime / day <= 2) {
      duration = 'yesterday';
    } else if (leftTime / hour >= 1) {
      duration = (leftTime / hour).floor().toString() + ' hours ago';
    } else if (leftTime / minute >= 1) {
      duration = (leftTime / minute).floor().toString() + '  mins ago';
    } else {
      duration = 'Just now';
    }
    return duration;
  }

  static final num ONE_MINUTE = 60000;
  static final num ONE_HOUR = 3600000;
  static final num ONE_DAY = 86400000;
  static final num ONE_WEEK = 604800000;

  static final String ONE_SECOND_AGO = "秒前";
  static final String ONE_MINUTE_AGO = "分钟前";
  static final String ONE_HOUR_AGO = "小时前";
  static final String ONE_DAY_AGO = "天前";
  static final String ONE_MONTH_AGO = "月前";
  static final String ONE_YEAR_AGO = "年前";

  /// 时间转换
  static String format(String formattedString) {
    DateTime date = DateTime.parse(formattedString);
    num delta = DateTime.now().millisecondsSinceEpoch - date.millisecondsSinceEpoch;
    if (delta < 1 * ONE_MINUTE) {
      num seconds = toSeconds(delta);
      return (seconds <= 0 ? 1 : seconds).toInt().toString() + ONE_SECOND_AGO;
    }
    if (delta < 45 * ONE_MINUTE) {
      num minutes = toMinutes(delta);
      return (minutes <= 0 ? 1 : minutes).toInt().toString() + ONE_MINUTE_AGO;
    }
    if (delta < 24 * ONE_HOUR) {
      num hours = toHours(delta);
      return (hours <= 0 ? 1 : hours).toInt().toString() + ONE_HOUR_AGO;
    }
    if (delta < 48 * ONE_HOUR) {
      return "昨天";
    }
    if (delta < 30 * ONE_DAY) {
      num days = toDays(delta);
      return (days <= 0 ? 1 : days).toInt().toString() + ONE_DAY_AGO;
    }
    if (delta < 12 * 4 * ONE_WEEK) {
      num months = toMonths(delta);
      return (months <= 0 ? 1 : months).toInt().toString() + ONE_MONTH_AGO;
    } else {
      num years = toYears(delta);
      return (years <= 0 ? 1 : years).toInt().toString() + ONE_YEAR_AGO;
    }
  }

  static num toSeconds(num date) {
    return date / 1000;
  }

  static num toMinutes(num date) {
    return toSeconds(date) / 60;
  }

  static num toHours(num date) {
    return toMinutes(date) / 60;
  }

  static num toDays(num date) {
    return toHours(date) / 24;
  }

  static num toMonths(num date) {
    return toDays(date) / 30;
  }

  static num toYears(num date) {
    return toMonths(date) / 365;
  }
}
