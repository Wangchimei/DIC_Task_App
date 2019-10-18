# DIC Exercise
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

### Model: Category
| Column | Type |
|:---:|:---:|
| id | integer |
| task_id | integer |
| label_id | integer |