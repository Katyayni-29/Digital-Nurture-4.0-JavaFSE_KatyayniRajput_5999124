import React from 'react';
import Post from './Post';

class Posts extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      posts: [],
    };
  }

  
loadPosts = async () => {
  try {
    const response = await fetch('https://jsonplaceholder.typicode.com/posts');
    if (!response.ok) {
      throw new Error('Network response was not ok');
    }
    const data = await response.json();
    this.setState({ posts: data.slice(0, 10) }); // limit to 10 posts
  } catch (error) {
    console.error('Fetch error:', error);
    this.setState({ hasError: true });
  }
};

 
  componentDidMount() {
    this.loadPosts();
  }
  

  componentDidCatch(error, info) {
  console.error('Error caught in componentDidCatch:', error, info);
  }

  render() {
  if (this.state.hasError) {
    return <h2 style={{ color: 'red' }}>Something went wrong while loading posts.</h2>;
  }

  return (
    <div style={{ padding: '20px' }}>
      <h1>📚 Blog Posts</h1>
      {this.state.posts.map((post) => (
        <Post key={post.id} title={post.title} body={post.body} />
      ))}
    </div>
  );
}
}

export default Posts;
