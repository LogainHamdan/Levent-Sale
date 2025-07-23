class FilterRequestDTO {
  String? sortBy;
  String? sortDirection;
  Map<String, dynamic>? filters;
  List<dynamic>? searchAttributes;

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
      filters: json['filters'] != null
          ? Map<String, dynamic>.from(json['filters'])
          : null,
      searchAttributes: json['searchAttributes'] != null
          ? List<dynamic>.from(json['searchAttributes'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (sortBy != null) 'sortBy': sortBy,
      if (sortDirection != null) 'sortDirection': sortDirection,
      if (filters != null) 'filters': filters,
      if (searchAttributes != null&&searchAttributes!=[]) 'searchAttributes': searchAttributes,
    };
  }
}
