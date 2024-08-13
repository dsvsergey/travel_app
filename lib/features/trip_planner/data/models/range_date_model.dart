import 'package:flutter/material.dart';
import '../../domain/entities/range.dart';

class RangeDateModel extends RangeDate {
  RangeDateModel({
    required super.start,
    required super.end,
    super.startColor,
    super.endColor,
    super.textColor,
    super.icon,
    super.toolTipEnMessage,
    super.toolTipArMessage,
  });

  factory RangeDateModel.fromJson(Map<String, dynamic> json) {
    return RangeDateModel(
      start: DateTime.parse(json['start']),
      end: DateTime.parse(json['end']),
      startColor:
          json['start_color'] != null ? Color(json['start_color']) : null,
      endColor: json['end_color'] != null ? Color(json['end_color']) : null,
      textColor: json['text_color'] != null ? Color(json['text_color']) : null,
      toolTipEnMessage: json['tooltip_en_message'] ?? '',
      toolTipArMessage: json['tooltip_ar_message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'start': start.toIso8601String(),
      'end': end.toIso8601String(),
      'start_color': startColor?.value,
      'end_color': endColor?.value,
      'text_color': textColor?.value,
      'tooltip_en_message': toolTipEnMessage,
      'tooltip_ar_message': toolTipArMessage,
    };
  }
}

extension RangeDateModelX on RangeDate {
  RangeDateModel toModel() => RangeDateModel(
        start: start,
        end: end,
        startColor: startColor,
        endColor: endColor,
        textColor: textColor,
        icon: icon,
        toolTipEnMessage: toolTipEnMessage,
        toolTipArMessage: toolTipArMessage,
      );
}

extension RangeDateX on RangeDateModel {
  RangeDate toEntity() => RangeDate(
        start: start,
        end: end,
        startColor: startColor,
        endColor: endColor,
        textColor: textColor,
        icon: icon,
        toolTipEnMessage: toolTipEnMessage,
        toolTipArMessage: toolTipArMessage,
      );
}
