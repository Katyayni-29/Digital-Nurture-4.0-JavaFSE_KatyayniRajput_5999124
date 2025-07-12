/*Hibernate Example*/
/* Method to CREATE an employee in the database */
public Integer addEmployee(Employee employee) {
    Session session = HibernateUtil.getSessionFactory().openSession(); // open session
    Transaction tx = null;
    Integer employeeID = null;

    try {
        tx = session.beginTransaction();              // begin transaction
        employeeID = (Integer) session.save(employee); // save employee object
        tx.commit();                                  // commit transaction
    } catch (HibernateException e) {
        if (tx != null) tx.rollback();               // rollback if error
        e.printStackTrace();                         // print error
    } finally {
        session.close();                             // close session
    }

    return employeeID;
}
