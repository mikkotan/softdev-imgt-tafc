# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(password: 'password',
            email: 'starjirachi1@yahoo.com',
            password_confirmation: 'password',
            first_name: 'Anfernee Joan',
            last_name: 'Ng',
            role: 'owner'
           )

User.create(password: 'tantantan',
            email: 'tantantan@yahoo.com',
            password_confirmation: 'tantantan',
            first_name: 'Michael Tan',
            last_name: 'Tan',
            role: 'owner'
           )

user = User.create(password: 'password',
                   email: 'keia123@gmail.com',
                   password_confirmation: 'password',
                   first_name: 'Keia Joy',
                   last_name: 'Harder',
                   role: 'employee'
                  )

Client.create(company_name: 'ACME Inc.',
              owner: 'Kalbo',
              representative: 'Michael',
              address: '32 Ledesma St.',
              tel_num: '337-6608',
              email: 'starjirachi1@yahoo.com',
              tin_num: '21312312-2312321',
              status: 'active',
              user: user
             )
client = Client.create(company_name: 'ACME Inc.',
                       owner: 'Kalbo',
                       representative: 'Michael',
                       address: '32 Ledesma St.',
                       tel_num: '337-6608',
                       email: 'starjirachi1@yahoo.com',
                       tin_num: '21312312-2312321',
                       status: 'active',
                       user: user
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
