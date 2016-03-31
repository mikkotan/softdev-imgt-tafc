# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(password: 'adminpassword',
            email: 'admin@gmail.com',
            password_confirmation: 'adminpassword',
            first_name: 'Christina',
            last_name: 'Gemora',
            role: 'owner'
           )

User.create(password: 'managerpassword',
            email: 'manager@gmail.com',
            password_confirmation: 'managerpassword',
            first_name: 'Manager',
            last_name: 'Manager',
            role: 'manager'
           )

user = User.create(password: 'employeepassword',
                   email: 'employee1@gmail.com',
                   password_confirmation: 'employeepassword',
                   first_name: 'Anfernee',
                   last_name: 'Ng',
                   role: 'employee'
                  )



client = Client.create(company_name: 'ACME Inc.',
                       owner: 'Juan Dela Cruz',
                       representative: 'Juanito Lopez',
                       address: '32 Ledesma St.',
                       tel_num: '337-6608',
                       email: 'ACMEINC@gmail.com',
                       tin_num: '213-232-232-321',
                       status: 'active',
                       user_id: 3
                      )

trans1 = Transaction.create(billing_num: '111', retainers_fee: 300, vat: 150, percentage: 300, client: client)

srv = Service.create(name: 'DTI Registration and Renewal',
                     monthly_fee: 1500
                    )
RelatedCost.create(nature: 'Registration Fees',
                   value: 250,
                   service: srv
                  )

Service.create(name: 'Intellectual Property Right Application(Copyright/Trademark)',
               monthly_fee: 5000
              )
