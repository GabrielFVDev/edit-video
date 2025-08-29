// Import necessário para VideoQuality
import '../video/video_model.dart';

class AppPreferencesModel {
  final String userId;
  final VideoQuality defaultVideoQuality;
  final bool autoJumpCut;
  final bool autoAudioEnhancement;
  final double defaultJumpCutThreshold;
  final bool keepOriginalFiles;
  final String defaultExportPath;
  final bool darkMode;
  final String language;
  final bool showProcessingNotifications;
  final bool autoUploadToCloud;

  AppPreferencesModel({
    required this.userId,
    this.defaultVideoQuality = VideoQuality.medium,
    this.autoJumpCut = true,
    this.autoAudioEnhancement = true,
    this.defaultJumpCutThreshold = 1.0,
    this.keepOriginalFiles = true,
    required this.defaultExportPath,
    this.darkMode = false,
    this.language = 'pt-BR',
    this.showProcessingNotifications = true,
    this.autoUploadToCloud = false,
  });

  factory AppPreferencesModel.fromMap(Map<String, dynamic> map) {
    return AppPreferencesModel(
      userId: map['user_id'] as String,
      defaultVideoQuality: VideoQuality.values.firstWhere(
        (e) => e.toString() == 'VideoQuality.${map['default_video_quality']}',
        orElse: () => VideoQuality.medium,
      ),
      autoJumpCut: (map['auto_jump_cut'] as int?) == 1,
      autoAudioEnhancement: (map['auto_audio_enhancement'] as int?) == 1,
      defaultJumpCutThreshold:
          map['default_jump_cut_threshold'] as double? ?? 1.0,
      keepOriginalFiles: (map['keep_original_files'] as int?) == 1,
      defaultExportPath: map['default_export_path'] as String,
      darkMode: (map['dark_mode'] as int?) == 1,
      language: map['language'] as String? ?? 'pt-BR',
      showProcessingNotifications:
          (map['show_processing_notifications'] as int?) == 1,
      autoUploadToCloud: (map['auto_upload_to_cloud'] as int?) == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'default_video_quality': defaultVideoQuality.toString().split('.').last,
      'auto_jump_cut': autoJumpCut ? 1 : 0,
      'auto_audio_enhancement': autoAudioEnhancement ? 1 : 0,
      'default_jump_cut_threshold': defaultJumpCutThreshold,
      'keep_original_files': keepOriginalFiles ? 1 : 0,
      'default_export_path': defaultExportPath,
      'dark_mode': darkMode ? 1 : 0,
      'language': language,
      'show_processing_notifications': showProcessingNotifications ? 1 : 0,
      'auto_upload_to_cloud': autoUploadToCloud ? 1 : 0,
    };
  }

  AppPreferencesModel copyWith({
    String? userId,
    VideoQuality? defaultVideoQuality,
    bool? autoJumpCut,
    bool? autoAudioEnhancement,
    double? defaultJumpCutThreshold,
    bool? keepOriginalFiles,
    String? defaultExportPath,
    bool? darkMode,
    String? language,
    bool? showProcessingNotifications,
    bool? autoUploadToCloud,
  }) {
    return AppPreferencesModel(
      userId: userId ?? this.userId,
      defaultVideoQuality: defaultVideoQuality ?? this.defaultVideoQuality,
      autoJumpCut: autoJumpCut ?? this.autoJumpCut,
      autoAudioEnhancement: autoAudioEnhancement ?? this.autoAudioEnhancement,
      defaultJumpCutThreshold:
          defaultJumpCutThreshold ?? this.defaultJumpCutThreshold,
      keepOriginalFiles: keepOriginalFiles ?? this.keepOriginalFiles,
      defaultExportPath: defaultExportPath ?? this.defaultExportPath,
      darkMode: darkMode ?? this.darkMode,
      language: language ?? this.language,
      showProcessingNotifications:
          showProcessingNotifications ?? this.showProcessingNotifications,
      autoUploadToCloud: autoUploadToCloud ?? this.autoUploadToCloud,
    );
  }

  @override
  String toString() {
    return 'AppPreferencesModel(userId: $userId, defaultVideoQuality: $defaultVideoQuality, autoJumpCut: $autoJumpCut)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppPreferencesModel && other.userId == userId;
  }

  @override
  int get hashCode => userId.hashCode;
}
