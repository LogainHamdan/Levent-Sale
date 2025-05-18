class FilterRequestDTO {
  String? sortBy;
  String? sortDirection;
  Map<String, dynamic>? filters;
  List<String>? searchAttributes;

  FilterRequestDTO({
    this.sortBy,
    this.sortDirection,
    this.filters,
    this.searchAttributes,
  });

  factory FilterRequestDTO.fromJson(Map<String, dynamic> json) {
    return FilterRequestDTO(
      sortBy: json['sortBy'],
      sortDirection: json['sortDirection'],
      filters: json['filters'] != null ? Map<String, dynamic>.from(json['filters']) : null,
      searchAttributes: json['searchAttributes'] != null ? List<String>.from(json['searchAttributes']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sortBy': sortBy,
      'sortDirection': sortDirection,
      'filters': filters,
      'searchAttributes': searchAttributes,
    };
  }
}
