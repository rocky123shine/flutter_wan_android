import 'dart:convert';
import 'dart:io';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:path_provider/path_provider.dart';

class ApolloUtils {
  static ApolloUtils? utils;

  ApolloUtils._();

  static getInstance() {
    utils ??= ApolloUtils._();
    return utils;
  }

  static ApolloUtils get instance => getInstance();

  query(String service, {Map<String, dynamic>? variables}) async {
    initHiveForFlutter();
    var op = QueryOptions(document: gql(""), variables: {});
    op.document = gql(service);
    op.variables = variables ?? {};
   // var request = op.asRequest;
    var client = await _getClient();
     QueryResult result = await client.query(op);
    if (result.hasException) {
      print(result.exception.toString());
    }
  }

  Future<GraphQLClient> _getClient() async {
    /// initialize Hive and wrap the default box in a HiveStore
    Directory tempDir = await getTemporaryDirectory();
    final store = await HiveStore.open(path: tempDir.path);
    return await GraphQLClient(
      /// pass the store to the cache for persistence
      cache: GraphQLCache(store: store),
      link: _link(),
    );
  }

  _link() {
    final _httpLink = HttpLink(
      'https://api.github.com/graphql',
    );

    final _authLink = AuthLink(
      getToken: () async => 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZGV2LmFwaS5yaXNlbGlua2VkdS5jb21cL2dyYXBocWxcL25vYXV0aCIsImlhdCI6MTU1ODMzNzI0MiwiZXhwIjoxNTY2OTc3MjQyLCJuYmYiOjE1NTgzMzcyNDIsImp0aSI6IkpNTWh5SGFzeUh0OWlRZWkiLCJzdWIiOjEzODgyLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.2sg930wR97nopcSpv4OuL7A9U4koXI3cIMR_RzG0ZqY',
    );

    Link _link = _authLink.concat(_httpLink);
    return _link;
  }
}
