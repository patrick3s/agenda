# Download dependencies 
flutter pub get 
# Run tests with User feedback (in case some test are failing)
flutter test
# Run tests without user feedback regeneration tests.output and coverage/lcov.info
flutter test --machine --coverage > tests.output 
# token 61aed4e114476a275b0eb70e81e780a12d918a92
# Run the analysis and publish to the SonarQube server
# sonar-scanner -Dsonar.login=token
/Users/patrick/Documents/repositories/docker-sonar/sonar-scanner-4.6.2.2472-macosx/bin/sonar-scanner  