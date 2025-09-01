from django.core.management.base import BaseCommand
from django.core.management import call_command

class Command(BaseCommand):
    help = 'Load sample data for library management system'

    def handle(self, *args, **options):
        self.stdout.write('Checking for existing sample data...')
        
        # Check if sample data already exists
        from home.models import AddBook, AddStudent, IssueBook
        
        if AddBook.objects.exists() or AddStudent.objects.exists() or IssueBook.objects.exists():
            self.stdout.write(
                self.style.WARNING('Sample data already exists!')
            )
            self.stdout.write(f'Books found: {AddBook.objects.count()}')
            self.stdout.write(f'Students found: {AddStudent.objects.count()}')
            self.stdout.write(f'Issued books found: {IssueBook.objects.count()}')
            self.stdout.write('\nTo reload sample data, clear the database first:')
            self.stdout.write('python manage.py flush')
            return
        
        self.stdout.write('Loading sample data...')
        
        try:
            call_command('loaddata', 'sample_data.json')
            self.stdout.write(
                self.style.SUCCESS('Successfully loaded sample data!')
            )
            self.stdout.write('\nSample data includes:')
            self.stdout.write('- 3 books (2 available, 1 issued)')
            self.stdout.write('- 1 student (John Smith)')
            self.stdout.write('- 1 issued book with expired date (to demonstrate fine calculation)')
            self.stdout.write('\nYou can now test the fine calculation feature!')
            
        except Exception as e:
            self.stdout.write(
                self.style.ERROR(f'Error loading sample data: {e}')
            )
