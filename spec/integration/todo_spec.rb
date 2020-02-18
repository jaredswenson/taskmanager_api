require 'swagger_helper'

describe 'Todo API' do

  path '/task/create' do

    post 'Creates a task' do
      tags 'Tasks'
      consumes 'application/json', 'application/xml'
      parameter name: :task, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :integer },
          name: { type: :string },
          is_completed: { type: :boolean }
        },
        required: [ 'user_id', 'name' ]
      }

      response '200', 'task created created' do
        let(:task) { { user_id: 1, name: 'test', is_completed: false } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:task) { { title: 'invalid' } }
        run_test!
      end
    end
  end

  path '/task/categories' do

    post 'Gets categories you can assign to a task' do
      tags 'Tasks'
      consumes 'application/json', 'application/xml'
      parameter name: :category, in: :body, schema: {
        type: :object,
        properties: {},
        required: []
      }

      response '200', 'Categories' do
        let(:category) { { id: 1, name: 'Home' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:task) { { title: 'invalid' } }
        run_test!
      end
    end
  end

  path '/task/update' do

    post 'Update a task' do
      tags 'Tasks'
      consumes 'application/json', 'application/xml'
      parameter name: :task, in: :body, schema: {
        type: :object,
        properties: {
            id: {type: :integer},
          user_id: { type: :integer },
          name: { type: :string },
          category: { type: :string },
          is_completed: { type: :boolean }
        },
        required: [ 'user_id', 'name' ]
      }

      response '200', 'task created created' do
        let(:task) { { user_id: 1, name: 'test', is_completed: false } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:task) { { title: 'invalid' } }
        run_test!
      end
    end
  end

  path '/task/get' do

    post 'Retrieves tasks for a user' do
      tags 'Tasks'
      produces 'application/json', 'application/xml'
      parameter name: :user_id, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :integer },
          is_completed: {type: :boolean}
        },
        required: [ 'user_id' ]
      }

      response '200', 'tasks found' do
        schema type: :Array,
          properties: { 
                id: { type: :integer },
                user_id: { type: :integer },
                name: { type: :string },
                is_completed: { type: :boolean }
          },
          required: [ 'id', 'user_id', 'name', 'is_completed' ]

        let(:id) { Task.create(user_id: 1, name: 'foo', is_completed: false).id }
        run_test!
      end

      response '404', 'tasks not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:'Accept') { 'application/foo' }
        run_test!
      end
    end
  end

  path '/auth/register' do

    post 'Register a user' do
      tags 'User'
      produces 'application/json', 'application/xml'
      parameter name: :user_id, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          password: { type: :string },
        },
        required: [ 'user_id' ]
      }

      response '200', 'tasks found' do
        schema type: :Array,
          properties: { 
                id: { type: :integer },
                name: { type: :string },
                email: { type: :string },
          },
          required: [ 'id', 'name', 'email' ]

        let(:id) { User.create(name: 'foo bar', email: 'foo@bar.com', password: 'password').id }
        run_test!
      end

      response '404', 'tasks not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:'Accept') { 'application/foo' }
        run_test!
      end
    end
  end

  path '/auth/login' do

    post 'Log a user in' do
      tags 'User'
      produces 'application/json', 'application/xml'
      parameter name: :user_id, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string },
        },
        required: [ 'user_id' ]
      }

      response '200', 'tasks found' do
        schema type: :Array,
          properties: { 
                email: { type: :string },
                password: { type: :string }
          },
          required: [ 'email', 'password' ]

        let(:id) { User.create(email: 'foo@bar.com', password: 'password').id }
        run_test!
      end

      response '404', 'tasks not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:'Accept') { 'application/foo' }
        run_test!
      end
    end
  end

end