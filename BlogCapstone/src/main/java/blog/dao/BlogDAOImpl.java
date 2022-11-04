package blog.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import blog.entities.Category;
import blog.entities.Post;
import blog.entities.User;

@Repository
public class BlogDAOImpl implements BlogDAO {

	@Autowired
	private JdbcTemplate jdbc;

	@Override
	public List<Category> getAllCategories() {
		final String s = "SELECT * FROM category";
		return jdbc.query(s, new CategoryMapper());
	}

	@Override
	public Category addCategory(Category category) {
		final String s = "INSERT INTO category(category) VALUES (?)";
		jdbc.update(s, category.getCategory());
		int newCategoryId = jdbc.queryForObject("SELECT LAST_INSERT_ID()", Integer.class);
		category.setId(newCategoryId);
		return category;
	}

	@Override
	public List<Post> getAllPosts() {
		final String s = "SELECT * FROM post";
		return jdbc.query(s, new PostMapper());
	}

	@Override
	public Post getPostById(int id) {
		final String s = "SELECT * FROM post WHERE id = ?";
		return jdbc.queryForObject(s, new PostMapper(), id);
	}

	@Override
	public Post addPost(Post post, int userId) {
		final String s = "INSERT INTO post(title, content, user_id) VALUES (?,?,?)";
		jdbc.update(s, post.getTitle(), post.getContent(), userId);
		int newPostId = jdbc.queryForObject("SELECT LAST_INSERT_ID()", Integer.class);
		post.setId(newPostId);
		return post;
	}

	@Override
	public void removePost(int id) {
		final String s = "DELETE FROM post WHERE id = ?";
		jdbc.update(s, id);
	}

	@Override
	public List<User> getAllUsers() {
		final String s = "SELECT * FROM user";
		return jdbc.query(s, new UserMapper());
	}

	@Override
	public User getUserById(int id) {
		final String s = "SELECT * FROM user WHERE id = ?";
		return jdbc.queryForObject(s, new UserMapper(), id);
	}


//	================= RowMappers ================

	public static final class PostMapper implements RowMapper<Post> {
		@Override
		public Post mapRow(ResultSet rs, int rowNum) throws SQLException {
			Post p = new Post();
			p.setId(rs.getInt("id"));
			p.setTitle(rs.getString("title"));
			p.setContent(rs.getString("content"));

			Timestamp timestamp = rs.getTimestamp("time");
			p.setTime(timestamp.toLocalDateTime());

			p.setUserId(rs.getInt("user_id"));
			p.setApproved(rs.getBoolean("approved"));
			return p;
		}
	}

	public static final class CategoryMapper implements RowMapper<Category> {
		@Override
		public Category mapRow(ResultSet rs, int rowNum) throws SQLException {
			Category c = new Category();
			c.setId(rs.getInt("id"));
			c.setCategory(rs.getString("category"));
			return c;
		}
	}

	public static final class UserMapper implements RowMapper<User> {
		@Override
		public User mapRow(ResultSet rs, int rowNum) throws SQLException {
			User u = new User();
			u.setId(rs.getInt("id"));
			u.setFirstName(rs.getString("first_name"));
			u.setLastName(rs.getString("last_name"));
			u.setEmail(rs.getString("email"));
			u.setPassword(rs.getString("password"));
			u.setRole(rs.getString("role"));
			return u;
		}
	}

}
