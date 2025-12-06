import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/classroom/v1.dart';
import 'package:student_sphere/core/errors/exceptions.dart';

class ClassroomService {
  final GoogleSignIn _googleSignIn;

  ClassroomService(this._googleSignIn);

  Future<List<Course>> fetchCourses() async {
    try {
      final httpClient = await _googleSignIn.authenticatedClient();
      if (httpClient == null) {
        throw ServerException('User not authenticated');
      }

      final classroomApi = ClassroomApi(httpClient);
      final response =
          await classroomApi.courses.list(courseStates: ['ACTIVE']);
      return response.courses ?? [];
    } catch (e) {
      throw ServerException('Failed to fetch courses: $e');
    }
  }

  Future<List<CourseWork>> fetchCourseWork(String courseId) async {
    try {
      final httpClient = await _googleSignIn.authenticatedClient();
      if (httpClient == null) {
        throw ServerException('User not authenticated');
      }

      final classroomApi = ClassroomApi(httpClient);
      final response = await classroomApi.courses.courseWork.list(courseId);
      return response.courseWork ?? [];
    } catch (e) {
      throw ServerException('Failed to fetch coursework: $e');
    }
  }

  Future<List<Announcement>> fetchAnnouncements(String courseId) async {
    try {
      final httpClient = await _googleSignIn.authenticatedClient();
      if (httpClient == null) {
        throw ServerException('User not authenticated');
      }

      final classroomApi = ClassroomApi(httpClient);
      final response = await classroomApi.courses.announcements.list(courseId);
      return response.announcements ?? [];
    } catch (e) {
      throw ServerException('Failed to fetch announcements: $e');
    }
  }
}
