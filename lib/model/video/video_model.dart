enum VideoStatus { processing, completed, failed, uploaded }

enum VideoQuality { low, medium, high, ultra }

class VideoModel {
  final String id;
  final String title;
  final String description;
  final String originalPath;
  final String? processedPath;
  final String? thumbnailPath;
  final VideoStatus status;
  final VideoQuality quality;
  final DateTime createdAt;
  final DateTime? processedAt;
  final int durationInSeconds;
  final int fileSizeInBytes;
  final String userId; // Relaciona com o usuário

  // Configurações de processamento
  final bool jumpCutEnabled;
  final bool audioEnhancementEnabled;
  final double jumpCutThreshold; // Threshold para detectar pausas (em segundos)

  // Metadados de processamento
  final Map<String, dynamic>? processingMetadata;

  VideoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.originalPath,
    this.processedPath,
    this.thumbnailPath,
    required this.status,
    this.quality = VideoQuality.medium,
    required this.createdAt,
    this.processedAt,
    required this.durationInSeconds,
    required this.fileSizeInBytes,
    required this.userId,
    this.jumpCutEnabled = true,
    this.audioEnhancementEnabled = true,
    this.jumpCutThreshold = 1.0, // 1 segundo de pausa por padrão
    this.processingMetadata,
  });

  // Factory constructor para criar a partir de Map (SQLite)
  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      originalPath: map['original_path'] as String,
      processedPath: map['processed_path'] as String?,
      thumbnailPath: map['thumbnail_path'] as String?,
      status: VideoStatus.values.firstWhere(
        (e) => e.toString() == 'VideoStatus.${map['status']}',
      ),
      quality: VideoQuality.values.firstWhere(
        (e) => e.toString() == 'VideoQuality.${map['quality']}',
      ),
      createdAt: DateTime.parse(map['created_at'] as String),
      processedAt: map['processed_at'] != null
          ? DateTime.parse(map['processed_at'] as String)
          : null,
      durationInSeconds: map['duration_in_seconds'] as int,
      fileSizeInBytes: map['file_size_in_bytes'] as int,
      userId: map['user_id'] as String,
      jumpCutEnabled: (map['jump_cut_enabled'] as int) == 1,
      audioEnhancementEnabled: (map['audio_enhancement_enabled'] as int) == 1,
      jumpCutThreshold: map['jump_cut_threshold'] as double,
      processingMetadata: map['processing_metadata'] != null
          ? Map<String, dynamic>.from(map['processing_metadata'] as Map)
          : null,
    );
  }

  // Converter para Map (SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'original_path': originalPath,
      'processed_path': processedPath,
      'thumbnail_path': thumbnailPath,
      'status': status.toString().split('.').last,
      'quality': quality.toString().split('.').last,
      'created_at': createdAt.toIso8601String(),
      'processed_at': processedAt?.toIso8601String(),
      'duration_in_seconds': durationInSeconds,
      'file_size_in_bytes': fileSizeInBytes,
      'user_id': userId,
      'jump_cut_enabled': jumpCutEnabled ? 1 : 0,
      'audio_enhancement_enabled': audioEnhancementEnabled ? 1 : 0,
      'jump_cut_threshold': jumpCutThreshold,
      'processing_metadata': processingMetadata,
    };
  }

  // CopyWith para imutabilidade
  VideoModel copyWith({
    String? id,
    String? title,
    String? description,
    String? originalPath,
    String? processedPath,
    String? thumbnailPath,
    VideoStatus? status,
    VideoQuality? quality,
    DateTime? createdAt,
    DateTime? processedAt,
    int? durationInSeconds,
    int? fileSizeInBytes,
    String? userId,
    bool? jumpCutEnabled,
    bool? audioEnhancementEnabled,
    double? jumpCutThreshold,
    Map<String, dynamic>? processingMetadata,
  }) {
    return VideoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      originalPath: originalPath ?? this.originalPath,
      processedPath: processedPath ?? this.processedPath,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
      status: status ?? this.status,
      quality: quality ?? this.quality,
      createdAt: createdAt ?? this.createdAt,
      processedAt: processedAt ?? this.processedAt,
      durationInSeconds: durationInSeconds ?? this.durationInSeconds,
      fileSizeInBytes: fileSizeInBytes ?? this.fileSizeInBytes,
      userId: userId ?? this.userId,
      jumpCutEnabled: jumpCutEnabled ?? this.jumpCutEnabled,
      audioEnhancementEnabled:
          audioEnhancementEnabled ?? this.audioEnhancementEnabled,
      jumpCutThreshold: jumpCutThreshold ?? this.jumpCutThreshold,
      processingMetadata: processingMetadata ?? this.processingMetadata,
    );
  }

  // Helpers para facilitar uso na UI
  String get statusDisplayName {
    switch (status) {
      case VideoStatus.processing:
        return 'Processando';
      case VideoStatus.completed:
        return 'Concluído';
      case VideoStatus.failed:
        return 'Falhou';
      case VideoStatus.uploaded:
        return 'Carregado';
    }
  }

  String get qualityDisplayName {
    switch (quality) {
      case VideoQuality.low:
        return 'Baixa (480p)';
      case VideoQuality.medium:
        return 'Média (720p)';
      case VideoQuality.high:
        return 'Alta (1080p)';
      case VideoQuality.ultra:
        return 'Ultra (4K)';
    }
  }

  String get formattedDuration {
    final minutes = durationInSeconds ~/ 60;
    final seconds = durationInSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String get formattedFileSize {
    if (fileSizeInBytes < 1024 * 1024) {
      return '${(fileSizeInBytes / 1024).toStringAsFixed(1)} KB';
    } else if (fileSizeInBytes < 1024 * 1024 * 1024) {
      return '${(fileSizeInBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    } else {
      return '${(fileSizeInBytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
    }
  }

  bool get isProcessed => status == VideoStatus.completed;
  bool get isProcessing => status == VideoStatus.processing;
  bool get hasFailed => status == VideoStatus.failed;

  @override
  String toString() {
    return 'VideoModel(id: $id, title: $title, status: $status, quality: $quality, duration: $formattedDuration)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VideoModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
