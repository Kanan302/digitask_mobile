enum AppRoutes {
  splash(path: '/', name: 'splash'),
  onboarding(path: '/onboarding', name: 'onboarding'),
  login(path: '/login', name: 'login'),
  home(path: '/home', name: 'home'),
  notification(path: 'notification', name: 'notification'),
  anbar(path: 'anbar', name: 'anbar'),
  chat(path: 'chat', name: 'chat'),
  createTask(path: 'createTask', name: 'createTask'),
  profile(path: 'profile', name: 'profile'),
  profileEdit(path: 'profileEdit', name: 'profileEdit');



  const AppRoutes({required this.path, required this.name});
  final String path;
  final String name;
}
