class GoRouterNames {
  // Top Level
  static const signIn = 'sign-in';
  static const home = 'home';
  static const error = 'error';
  static const logs = 'logs';

  // Feature Switcher
  static const featureSwitcher = 'feature-switcher';

  // Coaches
  static const coaches = 'coaches';
  static const coachDetails = 'coach';
  static const addCoach = 'add-coach';

  // Students
  static const students = 'students';
  static const studentDetails = 'student';
  static const addStudent = 'add-student';

  // Courses
  static const courses = 'courses';
  static const courseDetails = 'course';
  static const addCourse = 'add-course';
  static const selectSchool = 'select-school';


  // Classes
  static const classes = 'classes';
  static const classDetails = 'class';
}

class GoRouterPath {
  // Top Level Routes (start with / and dont have parent routes)
  static const home = '/';
  static const signIn = '/signin';
  static const error = '/error';
  static const logs = '/logs';

  // Feature Switcher
  static const featureSwitcher = 'feature-switcher';

  // Coaches
  static const coaches = 'coaches';
  static const coachDetails = ':coachId';
  static const addCoach = 'add-coach';

  // Students
  static const students = 'students';
  static const studentDetails = ':studentId';
  static const addStudent = 'add-student';

  // Courses
  static const courses = 'courses';
  static const courseDetails = ':courseId';
  static const addCourse = 'add-course:schoolId';
  static const selectSchool = 'select-school';

  // Classes
  static const classes = 'classes';
  static const classDetails = ':classId';
}
