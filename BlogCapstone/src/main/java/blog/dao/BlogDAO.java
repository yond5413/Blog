package blog.dao;

import java.util.List;

import blog.entities.Category;
import blog.entities.Post;
import blog.entities.User;

public interface BlogDAO {
	
	List<Category> getAllCategories();
	
	Category addCategory(Category category);
	
	List<Post> getAllPosts();
	
	Post getPostById(int id);
	
	Post addPost(Post post, int userId);
	
	void removePost(int id);
	
	List<User> getAllUsers();
	
	User getUserById(int id);


}
