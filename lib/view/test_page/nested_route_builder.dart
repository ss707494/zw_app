
import 'package:flutter/material.dart';

typedef Widget NestedRouteBuilder(Widget child);

@immutable
class NestedRoute {
  final String name;
  final List<NestedRoute> subRoutes;
  final NestedRouteBuilder builder;

  const NestedRoute({@required this.name, this.subRoutes, @required this.builder});

  Route buildRoute(List<String> paths, int index) {
    return new PageRouteBuilder<dynamic>(
      pageBuilder: (_, __, ___) => _build(paths, index),
    );
  }

  Widget _build(List<String> paths, int index) {
    if (index >= paths.length) {
      return builder(null);
    }
    final route = subRoutes?.firstWhere((route) => route.name == paths[index], orElse: () => null);
    return builder(route?._build(paths, index + 1));
  }
}

RouteFactory buildNestedRoutes(List<NestedRoute> routes) {
  return (RouteSettings settings) {
    final paths = settings.name.split('/');
    if (paths.length <= 1) {
      return null;
    }
    final rootRoute = routes.firstWhere((route) => route.name == paths[1]);
    return rootRoute.buildRoute(paths, 2);
  };
}

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/foo/bar',
      home: Text('home'),
      onGenerateRoute: buildNestedRoutes(
        [
          new NestedRoute(
            name: 'foo',
            builder: (child) => new Center(child: child),
            subRoutes: [
              new NestedRoute(
                name: 'bar',
                builder: (_) => const Text('bar'),
              ),
              new NestedRoute(
                name: 'baz',
                builder: (_) => const Text('baz'),
              )
            ],
          ),
        ],
      ),
    );
  }
}

