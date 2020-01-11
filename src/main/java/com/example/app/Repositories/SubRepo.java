package com.example.app.Repositories;import com.example.app.Repositories.dao.SubDao;import com.example.app.config.HibernateUtil;import com.example.app.domain.User;import org.hibernate.Session;import org.hibernate.SessionFactory;import org.hibernate.Transaction;import org.hibernate.query.Query;public class SubRepo implements SubDao {    private static SessionFactory sessionFactory;    static {        sessionFactory = HibernateUtil.getSessionFactory();    }    @Override    public void subscribe(User user, User currentUser) {        Session session = null;        Transaction transaction = null;        try{            session = sessionFactory.openSession();            transaction = session.beginTransaction();            Query query = session.createSQLQuery("CALL Subscribe(:id, :sub_id)")                    .setParameter("id", user.getId())                    .setParameter("sub_id", currentUser.getId());            query.executeUpdate();        } catch (Exception e){            if(transaction != null)                transaction.commit();            System.err.println(e.getMessage());        } finally {            session.close();        }    }    @Override    public void unsubscribe(User user, User currentUser) {        Session session = null;        Transaction transaction = null;        try {            session = sessionFactory.openSession();            transaction = session.beginTransaction();            Query query = session.createSQLQuery("CALL Unsubscribe(:id, :sub_id)")                    .setParameter("id", user.getId())                    .setParameter("sub_id", currentUser.getId());            query.executeUpdate();        } catch (Exception e){            if(transaction != null)                transaction.commit();            System.err.println(e.getMessage());        } finally {            session.close();        }    }}