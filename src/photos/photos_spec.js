import { expect } from 'chai';
import { PhotoDialog } from './photos';
import env from '../env';

describe('Photos Dialog', () => {
  it('Initiates', () => {
    expect(PhotoDialog()).to.equal("Where the fuck are your photos?");
  });

  it('should load test environment variables', () => {
    expect(env.name).to.equal('test');
    expect(env.description).to.equal('Add here any environment specific stuff you like.');
  });
});
