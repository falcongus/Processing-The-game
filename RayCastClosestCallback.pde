import org.jbox2d.callbacks.RayCastCallback;

static class EdgeShapesCallback implements RayCastCallback {
   
  Fixture m_fixture = null;
  Vec2 m_point;
  Vec2 m_normal;
 
  public float reportFixture(Fixture fixture, final Vec2 point, final Vec2 normal, float fraction) {
    m_fixture = fixture;
    m_point = point;
    m_normal = normal;
    return fraction;
  }
}