package com.example.app.Repositories;import antlr.debug.MessageAdapter;import com.example.app.Repositories.dao.MessageDao;import com.example.app.config.HibernateUtil;import com.example.app.domain.Message;import com.example.app.domain.User;import com.example.app.domain.dto.MessageDto;import org.hibernate.Session;import org.hibernate.SessionFactory;import org.hibernate.Transaction;import org.hibernate.query.Query;import org.hibernate.transform.Transformers;import java.util.LinkedList;import java.util.List;public class MessageRepo implements MessageDao {    private static SessionFactory sessionFactory;    private UserRepo userRepo = new UserRepo();    static {        sessionFactory = HibernateUtil.getSessionFactory();    }    @Override    public Message getById(Long id) {        return null;    }    @Override    public List<Message> getByTag(String tag) {        Session session = null;        Transaction transaction = null;        List messages = null;        try{            session = sessionFactory.openSession();            transaction = session.beginTransaction();            Query query = session.createSQLQuery("CALL GetMessageByTag(:tag)")                    .addEntity(Message.class)                    .setParameter("tag", tag);            messages = query.list();        } catch (Exception e){            System.out.println("ERROR");            if(transaction != null)                transaction.commit();        } finally {            session.close();        }        return messages;    }    @Override    public List<Message> getAll() {        Session session = null;        Transaction transaction = null;        List messages = null;        try{            session = sessionFactory.openSession();            transaction = session.beginTransaction();            Query query = session.createSQLQuery("CALL GetAllMessages()")                    .addEntity(Message.class);            messages = query.list();        } catch (Exception e){            if(transaction != null)                transaction.commit();            System.out.println("ERROR");        } finally {            session.close();        }        return messages;    }    @Override    public void update(Message message) {        Session session = null;        Transaction transaction = null;        List messages = null;        try{            session = sessionFactory.openSession();            transaction = session.beginTransaction();            Query query = session.createSQLQuery("CALL UpdateMessage(:id, :filename, :tag, :text, :user_id)")                    .addEntity(Message.class)                    .setParameter("id", message.getId())                    .setParameter("filename", message.getFilename())                    .setParameter("tag", message.getTag())                    .setParameter("text", message.getText())                    .setParameter("user_id", message.getAuthor().getId());            query.executeUpdate();        } catch (Exception e){            if(transaction != null);                transaction.commit();            System.out.println("ERROR");        } finally {            session.close();        }    }    @Override    public void delete(Message message) {    }    @Override    public List<Message> getMessagesByUser(User user) {        Session session = null;        Transaction transaction = null;        List messages = null;        try{            session = sessionFactory.openSession();            transaction = session.beginTransaction();            Query query = session.createSQLQuery("CALL GetMessagesByUserId(:user_id)")                    .addEntity(Message.class)                    .setParameter("user_id", user.getId());            messages = query.list();        } catch (Exception e){            if(transaction != null);                transaction.commit();            System.out.println("ERROR");        } finally {            session.close();        }        return messages;    }    @Override    public void addMessage(Message message) {        Session session = null;        Transaction transaction = null;        List messages = null;        try{            session = sessionFactory.openSession();            transaction = session.beginTransaction();            Query query = session.createSQLQuery("CALL AddMessage(:filename, :tag, :text, :user_id)")                    .addEntity(Message.class)                    .setParameter("filename", message.getFilename())                    .setParameter("tag", message.getTag())                    .setParameter("text", message.getText())                    .setParameter("user_id", message.getAuthor().getId());            query.executeUpdate();        } catch (Exception e){            if(transaction != null);                transaction.commit();            System.out.println("ERROR");        } finally {            session.close();        }    }    @Override    public List<Message> getSubMessagesByUsers(User user){        Session session = null;        Transaction transaction = null;        List messages = null;        try {            session = sessionFactory.openSession();            transaction = session.beginTransaction();            Query query = session.createSQLQuery("CALL GetSubMessagesByUsers(:id)")                    .addEntity(Message.class)                    .setParameter("id", user.getId());            messages = query.list();        } catch (Exception e){            if(transaction != null)                transaction.commit();        } finally {            session.close();        }        return messages;    }    @Override    public List<Message> getSubMessagesByUsersAndByTag(User user, String tag) {        Session session = null;        Transaction transaction = null;        List messages = null;        try {            session = sessionFactory.openSession();            transaction = session.beginTransaction();            Query query = session.createSQLQuery("CALL GetSubMessagesByUsersAndTag(:id, :tag)")                    .addEntity(Message.class)                    .setParameter("id", user.getId())                    .setParameter("tag", tag);            messages = query.list();        } catch (Exception e){            if(transaction != null)                transaction.commit();        } finally {            session.close();        }        return messages;    }    @Override    public void like(User user, Message message) {        Session session = null;        Transaction transaction = null;        try {            session = sessionFactory.openSession();            transaction = session.beginTransaction();            Query query = session.createSQLQuery("CALL LikeMessage(:user_id, :message_id)")                    .setParameter("user_id", user.getId())                    .setParameter("message_id", message.getId());            query.executeUpdate();        } catch (Exception e){            if(transaction != null)                transaction.commit();        } finally {            session.close();        }    }    @Override    public void dislike(User user, Message message) {        Session session = null;        Transaction transaction = null;        try {            session = sessionFactory.openSession();            transaction = session.beginTransaction();            Query query = session.createSQLQuery("CALL DislikeMessage(:u_id, :m_id)")                    .setParameter("u_id", user.getId())                    .setParameter("m_id", message.getId());            query.executeUpdate();        } catch (Exception e){            if(transaction != null)                transaction.commit();        } finally {            session.close();        }    }    public List<MessageDto> getAllMessagesDto(User currentUser) {        Session session = null;        Transaction transaction = null;        List<MessageDto> messages = new LinkedList<>();        try {            session = sessionFactory.openSession();            transaction = session.beginTransaction();            Query query = session.createSQLQuery("CALL GetAllMessageDto(:cur_id)")                    .setResultTransformer(Transformers.aliasToBean(MessageDto.class))                    .setParameter("cur_id", currentUser.getId());            for(Object obj :  query.list()) {                messages.add((MessageDto)obj);            }            for (MessageDto msdo : messages) {                msdo.setAuthor(userRepo.getUserById(msdo.getAuthor_id()));            }            System.out.println("Count - " + messages.size());        } catch (Exception e){            if(transaction != null)                transaction.commit();            System.out.println(e.getMessage());        } finally {            session.close();        }        return messages;    }}