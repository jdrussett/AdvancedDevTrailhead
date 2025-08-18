global class CaseService {
  private static final String STATUS_CLOSED = 'Closed';
  global static void closeCases(Set<Id> caseIds, String closeReason) {
    List<Case> toUpdate = new List<Case>();
    for (Id caseId : caseIds) {
      toUpdate.add(new Case(
        Id = caseId,
        Status = STATUS_CLOSED,
        Reason = closeReason
      ));
    }
    Database.update(toUpdate, /* allOrNone */ true, AccessLevel.USER_MODE);
  }
}