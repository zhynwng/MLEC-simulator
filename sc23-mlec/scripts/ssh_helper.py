import os

def put_dir(conn, source, target):
    ''' Uploads the contents of the source directory to the target path. The
        target directory needs to exists. All subdirectories in source are 
        created under target.
    '''
    for item in os.listdir(source):
        if os.path.isfile(os.path.join(source, item)):
            conn.put(os.path.join(source, item), '%s/%s' % (target, item))
        else:
            conn.run(f"mkdir -p {target}/{item}")
            put_dir(conn, os.path.join(source, item), '%s/%s' % (target, item))

__all__ = ["put_dir"]