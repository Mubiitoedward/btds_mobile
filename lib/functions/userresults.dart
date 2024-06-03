class UserResults {
 final String label;
 final double confidence;
 final String recordedAt;

  UserResults({
   required this.label,
   required this.confidence,
   required this.recordedAt,
  });

   Map<String, dynamic> toJson() => {
        'confidence': confidence.toString(),
        'label': label,
        'recordedAt' : recordedAt.toString()
      };
}
