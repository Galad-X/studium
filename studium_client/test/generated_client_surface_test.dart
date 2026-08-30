import 'package:studium_client/studium_client.dart';
import 'package:test/test.dart';

void main() {
  test('generated collaboration and opportunity client surface is exported',
      () {
    final client = Client('http://127.0.0.1:1');

    expect(client.collaboration.searchInstitutions, isA<Function>());
    expect(client.collaboration.getMyMemberships, isA<Function>());
    expect(client.collaboration.getRooms, isA<Function>());
    expect(client.collaboration.createRoom, isA<Function>());
    expect(client.collaboration.getRoomPosts, isA<Function>());
    expect(client.collaboration.getChallenges, isA<Function>());
    expect(client.collaboration.createChallenge, isA<Function>());
    expect(client.collaboration.getRoomResources, isA<Function>());
    expect(client.collaboration.askRoom, isA<Function>());
    expect(client.opportunity.getOpportunities, isA<Function>());
    expect(client.opportunity.saveOpportunity, isA<Function>());
  });
}
