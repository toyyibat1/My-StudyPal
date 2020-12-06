class UserModel {
  String uid;
  String email;
  String firstName;
  String lastName;
  String photoUrl;
  String institution;
  String course;
  String studyGoals;
  String periodToBeAchieved;
  String endOfSemester;
  String startOfSemester;
  String startOfExam;
  String endOfExam;
  String taskName;
  String taskDescription;
  String taskDate;
  String taskStart;
  String taskEnd;

  UserModel(
      {this.uid,
      this.email,
      this.firstName,
      this.lastName,
      this.photoUrl,
      this.course,
      this.endOfExam,
      this.endOfSemester,
      this.institution,
      this.periodToBeAchieved,
      this.startOfExam,
      this.startOfSemester,
      this.studyGoals,
      this.taskDate,
      this.taskDescription,
      this.taskEnd,
      this.taskStart,
      this.taskName});

  factory UserModel.fromMap(Map data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'] ?? '',
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'],
      photoUrl: data['photoUrl'] ?? '',
      institution: data['institution'] ?? '',
      course: data['course'] ?? '',
      studyGoals: data['studyGoals'] ?? '',
      periodToBeAchieved: data['periodToBeAchieved'] ?? '',
      endOfSemester: data['endOfSemester'] ?? '',
      startOfSemester: data['startOfSemester'] ?? '',
      startOfExam: data['startOfExam'] ?? '',
      endOfExam: data['endOfExam'] ?? '',
      taskDescription: data['taskDescription'] ?? '',
      taskEnd: data['taskEnd'] ?? '',
      taskDate: data['taskDate'] ?? '',
      taskStart: data['taskStart'] ?? '',
      taskName: data['taskName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "photUrl": photoUrl,
        "institution": institution,
        "course": course,
        "studyGoals": studyGoals,
        "periodToBeAchieved": periodToBeAchieved,
        "endOfSemester": endOfSemester,
        "startOfSemester": startOfSemester,
        "startOfExam": startOfExam,
        "endOfExam": endOfExam,
        "taskDescription": taskDescription,
        "taskDate": taskDate,
        "taskStart": taskStart,
        "taskEnd": taskEnd,
        "taskName": taskName,
      };
}
