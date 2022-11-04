/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package blog.dao;

import blog.TestApplicationConfiguration;
import blog.entities.Category;
import blog.entities.Post;
import java.util.List;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

/**
 *
 * @author 
 */

@RunWith(SpringRunner.class)
@SpringBootTest(classes = TestApplicationConfiguration.class)
public class BlogDAOImplTest {
    
    @Autowired
    BlogDAO testDao;
    
    public BlogDAOImplTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }
    
    @Before
    public void setUp() {
    }
    
    @After
    public void tearDown() {
    }

    /**
     * Test of getAllCategories method, of class BlogDAOImpl.
     */
    @Test
    public void testGetAllCategories() {
        List<Category> categories = testDao.getAllCategories();
        assertEquals(4, categories.size());
    }

    /**
     * Test of getAllPosts method, of class BlogDAOImpl.
     */
    @Test
    public void testGetAllPosts() {
        List<Post> posts = testDao.getAllPosts();
        assertEquals(3, posts.size());
    }

    /**
     * Test of getPostById method, of class BlogDAOImpl.
     */
    @Test
    public void testGetPostById() {
        Post currPost = testDao.getPostById(1);
        assertEquals(currPost.getTitle(), "Test Post");
    }

    /**
     * Test of addPost method, of class BlogDAOImpl.
     */
    @Test
    public void testAddPost() {
        Post newPost = new Post();
        newPost.setTitle("Black Friday Deals");
        newPost.setContent("Sample sample sample bla bla");
        
        testDao.addPost(newPost, 1);
        
        List<Post> posts = testDao.getAllPosts();
        Post lastPost = posts.get(posts.size() - 1);
        
        assertEquals(lastPost.getTitle(), newPost.getTitle());
        
    }

    
    
}
