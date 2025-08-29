enum ProcessingJobType { jumpcut, audioEnhancement, thumbnail, export }

enum ProcessingJobStatus { queued, processing, completed, failed, cancelled }

class ProcessingJobModel {
  final String id;
  final String videoId;
  final ProcessingJobType type;
  final ProcessingJobStatus status;
  final DateTime createdAt;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final int progress; // 0-100
  final String? errorMessage;
  final Map<String, dynamic>? parameters;
  final Map<String, dynamic>? result;

  ProcessingJobModel({
    required this.id,
    required this.videoId,
    required this.type,
    required this.status,
    required this.createdAt,
    this.startedAt,
    this.completedAt,
    this.progress = 0,
    this.errorMessage,
    this.parameters,
    this.result,
  });

  factory ProcessingJobModel.fromMap(Map<String, dynamic> map) {
    return ProcessingJobModel(
      id: map['id'] as String,
      videoId: map['video_id'] as String,
      type: ProcessingJobType.values.firstWhere(
        (e) => e.toString() == 'ProcessingJobType.${map['type']}',
      ),
      status: ProcessingJobStatus.values.firstWhere(
        (e) => e.toString() == 'ProcessingJobStatus.${map['status']}',
      ),
      createdAt: DateTime.parse(map['created_at'] as String),
      startedAt: map['started_at'] != null
          ? DateTime.parse(map['started_at'] as String)
          : null,
      completedAt: map['completed_at'] != null
          ? DateTime.parse(map['completed_at'] as String)
          : null,
      progress: map['progress'] as int? ?? 0,
      errorMessage: map['error_message'] as String?,
      parameters: map['parameters'] != null
          ? Map<String, dynamic>.from(map['parameters'] as Map)
          : null,
      result: map['result'] != null
          ? Map<String, dynamic>.from(map['result'] as Map)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'video_id': videoId,
      'type': type.toString().split('.').last,
      'status': status.toString().split('.').last,
      'created_at': createdAt.toIso8601String(),
      'started_at': startedAt?.toIso8601String(),
      'completed_at': completedAt?.toIso8601String(),
      'progress': progress,
      'error_message': errorMessage,
      'parameters': parameters,
      'result': result,
    };
  }

  ProcessingJobModel copyWith({
    String? id,
    String? videoId,
    ProcessingJobType? type,
    ProcessingJobStatus? status,
    DateTime? createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
    int? progress,
    String? errorMessage,
    Map<String, dynamic>? parameters,
    Map<String, dynamic>? result,
  }) {
    return ProcessingJobModel(
      id: id ?? this.id,
      videoId: videoId ?? this.videoId,
      type: type ?? this.type,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      progress: progress ?? this.progress,
      errorMessage: errorMessage ?? this.errorMessage,
      parameters: parameters ?? this.parameters,
      result: result ?? this.result,
    );
  }

  String get typeDisplayName {
    switch (type) {
      case ProcessingJobType.jumpcut:
        return 'Jump Cut';
      case ProcessingJobType.audioEnhancement:
        return 'Melhoria de Áudio';
      case ProcessingJobType.thumbnail:
        return 'Thumbnail';
      case ProcessingJobType.export:
        return 'Exportação';
    }
  }

  String get statusDisplayName {
    switch (status) {
      case ProcessingJobStatus.queued:
        return 'Na fila';
      case ProcessingJobStatus.processing:
        return 'Processando';
      case ProcessingJobStatus.completed:
        return 'Concluído';
      case ProcessingJobStatus.failed:
        return 'Falhou';
      case ProcessingJobStatus.cancelled:
        return 'Cancelado';
    }
  }

  bool get isCompleted => status == ProcessingJobStatus.completed;
  bool get isProcessing => status == ProcessingJobStatus.processing;
  bool get hasFailed => status == ProcessingJobStatus.failed;
  bool get isCancelled => status == ProcessingJobStatus.cancelled;
  bool get isQueued => status == ProcessingJobStatus.queued;

  Duration? get processingDuration {
    if (startedAt != null && completedAt != null) {
      return completedAt!.difference(startedAt!);
    }
    return null;
  }

  @override
  String toString() {
    return 'ProcessingJobModel(id: $id, type: $type, status: $status, progress: $progress%)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProcessingJobModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
