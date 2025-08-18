public with sharing class BusScheduleCache {
  private Cache.OrgPartition part;
  public BusScheduleCache() {
   this.part = Cache.Org.getPartition('local.BusSchedule');
  }

  public void putSchedule(String busLine, List<Time> schedule) {
    if (this.part != null) {
      this.part.put('busLine', schedule);
    }
  }

  public List<Time> getSchedule(String busLine) {
    List<Time> schedule = (List<Time>)part.get(busLine);
    if (schedule?.isEmpty() || schedule == null) {
      schedule = new List<Time>{
        Time.newInstance(8, 0, 0, 0),
        Time.newInstance(17, 0, 0, 0)
      };
    }
    return schedule;
  }
}