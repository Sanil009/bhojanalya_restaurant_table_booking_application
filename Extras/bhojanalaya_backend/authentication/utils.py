from django.core.mail import EmailMessage
from rest_framework_simplejwt.tokens import Token

class Util:
    @staticmethod
    def send_email(data):
        email = EmailMessage(
            subject=data['email_subject'], body=data['email_body'], to=[data['to_email']])
        email.send()





    # @staticmethod
    # def send_resetemail(data):
    #     email = EmailMessage(
    #         subject=data['email_subject'], body=data['email_body'], to=[data['to_email']])
    #     EmailThread(email).start()


# class EmailThread(threading.Thread):

#     def __init__(self, email):
#         self.email = email
#         threading.Thread.__init__(self)

#     def run(self):
#         self.email.send()


