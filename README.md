# DIC Exercise

## Development environment
ruby 2.6.5  
rails 5.2.3

## Data Structure
### Model: Task
| Column | Type |
|:---:|:---:|
|id| integer|
| title | string |
| content |text |
| deadline | datetime |
| priority | integer |
| status | integer |
| user_id | references|

### Model: User
| Column | Type |
|:---:|:---:|
| id | integer |
| name | string |
| email |string |
| password_digest | string |

### Model: Label
| Column | Type |
|:---:|:---:|
| id | integer |
| name | string |

### Model: Relation
| Column | Type |
|:---:|:---:|
| id | integer |
| task_id | integer |
| label_id | integer |

## Heroku deployment flow
1. Use the git commit command to commit changes made  
    `git add .`  
    `git commit -m "commit messages"`
2. Create a new application to Heroku  
    `heroku create`
3. Deploy to Heroku  
    `git push heroku master`
4. Execute database migration manually  
    `heroku run rake db:migrate`